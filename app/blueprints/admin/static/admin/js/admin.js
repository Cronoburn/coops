var Arthur = {
    connection: null,

    handle_message: function (message) {
        if ($(message).attr('from').match(/^pubsub\.coopslake\.solutions$/)){
            if ($(message).find('items').attr('node').match(/^blog\/home/)){
            var delayed = $(message).find('delay').length > 0;
            var body = $(message).find('event > items').contents();
            var messagebody = marked.parse($(message).find("entry > body").text())
            console.log("got it");
            console.log(message);
            var div = $("<div></div>");
            var messagebosy = marked.parse($(message).find("entry > body").text());
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
    }
};

$(document).ready(function () {
    
    $(document).trigger('connect', {
    jid: "blog@coopslake.solutions",
    password: "hazelmaewetdog",
    zone: $('#zone').val()});

    $('#login_dialog').dialog({
        autoOpen: true,
        dragable: true,
        modal: true,
        title: 'Login to Administration',
        buttons: {
            "Connect": function () {
                $(document).trigger('connect', {
                    jid: $('#jid').val(),
                    password: $('#password').val()
                });
            }
        }
    });
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
    Arthur.connection.addHandler(Arthur.handle_message,
                                null,
                                "message",
                                "headline"
                            );
    Arthur.connection.send($pres().c('priority').t('-1'));
});
$(document).bind('disconnected', function () {
    // placeholder
});