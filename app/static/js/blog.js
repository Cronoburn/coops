var Arthur = {
    connection: null,
// new method of retrieving entries pass zone and number of entries to retrieve
//   ... not working
    request_items: function(zone, qty) {
        console.log("sending request");
        var itemreq ={}
        if (qty < 1){
          itemreq = {"node":"blog/"+zone}
        } else {
          itemreq = {"node":"blog/"+zone, "max_items":qty}
        }
          Arthur.connection.sendIQ($iq({
              to: "pubsub.coopslake.solutions",
              type: "get"})
          .c("pubsub", {"xmlns":"http://jabber.org/protocol/pubsub"})
          .c("items", itemreq)
          );
        return true;
    },

// old, live message handling, we stopped using in favor of retrieving a number of existing entries at once
// it is important to note, this will NOT be present in final version
    handle_message: function (message) {
        if ($(message).attr('from').match(/^pubsub\.coopslake\.solutions$/)){
            if ($(message).find('items').attr('node').match(/^blog\/home/)){
            var delayed = $(message).find('delay').length > 0;
            var body = $(message).find('event > items').contents();
            var messagebody = marked.parse($(message).find("entry > body").text())
            console.log("got it");
            console.log(message);
            var div = $("<div></div>");
            var div1 = $build('div',{'class':'card text-body bg-primary mb-3 mx-auto mt-2','style':'max-width:80rem;'})
                .c('div',{'class':'card-header container-fluid'})
                .c('div',{'class':'row'})
                .c('div',{'class':'col-md-9'})
                .c('span',{'class':'coopdisp'},$(message).find("entry > title").text())
                /*.up().c('div',{'class':'d-flex'})*/
                .up().c('div',{'class':'col-md-3 float-right'})
                .c('span',{'class':'body-primary'},$(message).find("entry > published").text())
                .up().up().up().c('div',{'class':'card-body'});
            if (delayed) {
                $(div).addClass('delayed');
            }
            body.each(function () {
                    console.log("adding xml");
                    console.log(body);
                    console.log('boop');
                    $(div).append(div1.toString());
                    console.log("messagebody:\n"+messagebody);
            });
            
            console.log(div);
            $(div).prependTo('#stream');
            $(".card-body").append(messagebody);
        }
        }
        return true;
    },

// current method of handling a list of returned entries
    handle_list: function (iq) {
        console.log('got list');
        if ($(iq).attr('from').match(/^pubsub\.coopslake\.solutions$/)){
            if ($(iq).find('items').attr('node').match('blog/'+$('#zone').val())){
                var items = $(iq).find('item');
                var stream = $('<div id="stream-container" class="cls-card-container"></div>');
                $(items).each(function (item) {
                    var cur_item = $(items[item]);
                    var curId = "D"+$(cur_item).attr('id');
                    var messagebody = marked.parse($(cur_item).find("entry > body").text());
                    var cardContents = ""
                    +"<div class=\"card text-body glassed mb-3 mx-auto mt-2\" style=\"max-width:80rem;\">"
                    +"<div class=\"card-header container-fluid\" id=\""+curId+"\">"
                    +"<div class=\"row\">"
                    +"<div class=\"col-md-9\"><span class=\"coopdisp\">"+$(cur_item).find("entry > title").text()+"</span></div><div class=\"col-md-3 float-right\"><span class=\"body-primary\">"+$(cur_item).find('entry > published').text()+"</span></div></div>"
                    +"</div><div class=\"card-body glassed\">"
                    +messagebody
                    +"</div></div>";
                    console.log(cardContents);
                    $(stream).prepend(cardContents);
                });
                $(stream).prependTo('#stream');
                //$(document).trigger('list');
            }
        }
        return true;
    }
};

$(document).ready(function () {
    
    $(document).trigger('connect', {
    jid: "blog@coopslake.solutions",
    password: "hazelmaewetdog",
    zone: $('#zone').val()});

  
    $('#input').keyup(function () {
        var left = 250 - $(this).val().length;
        $('#coutner .count').text(''+left);
    });
    $('#btn-post').click( function(ev){
        var d = new Date();
        Arthur.connection.sendIQ($iq({to:"pubsub.coopslake.solutions",
                        type:"set",
                        from:"blog@coopslake.solutions"})
        .c('pubsub',{xmlns:"http://jabber.org/protocol/pubsub"})
        .c('publish',{node:"blog/home"})
        .c('item')
        .c('entry',{xmlns:"http://www.w3.org/2005/Atom"})
        .c('title').t($('#post-title').val())
        .up().c('body').t($('#wmd-input[name="post-body"]').val())
        .up().c('published').t(d.toISOString()));
    });
});
/*-- Attempting to connect --*/
$(document).bind('connect', function (ev, data) {
    console.log(data);
    var conn= new Strophe.Connection(
        'https://coopslake.solutions:5443/bosh');
    conn.connect(data.jid, data.password, function (status) {
        if (status === Strophe.Status.CONNECTED) {
            $(document).trigger('connected');
        } else if (status === Strophe.Status.DISCONNECTED) {
            $(document).trigger('disconnected');
        }
    });
    Arthur.connection = conn;
    Arthur.service = data.service;
    Arthur.node = data.node;
});
/*-- connection established --*/
$(document).bind('connected', function () {
    //Arthur.connection.addHandler(Arthur.handle_message,
    //            null,
    //            "message",
    //            "headline"
    //        );
    Arthur.connection.addHandler(Arthur.handle_list,
                null,
                "iq",
                "result"
            );
    Arthur.connection.send($pres().c('priority').t('-1'));
    Arthur.request_items($("#zone").val(),5);
});
$(document).bind('disconnected', function () {
    // placeholder
});