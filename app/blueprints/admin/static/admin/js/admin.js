var Arthur = {
    connection: null,
    request_items: function(zone, qty) {
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
    retract_item: function (id,zone) {
        Arthur.connection.sendIQ($iq({
          to: "pubsub.coopslake.solutions",
          type: "set"})
          .c("pubsub",{"xmlns": "http://jabber.org/protocol/pubsub"})
          .c("retract",{"node": "blog/"+zone})
          .c("item",{"id":id.substring(1)})
        );
      $('div#id').remove();
      return true;
    },

    handle_list: function (iq) {
        if ($(iq).attr('from').match(/^pubsub\.coopslake\.solutions$/)){
            if ($(iq).find('items').attr('node').match('blog/'+$('#zone').val())){
                var items = $(iq).find('item');
                var stream = $('<div id="stream-container" class="cls-card-container"></div>');
                $(items).each(function (item) {
                    var cur_item = $(items[item]);
                    var curId = "D"+$(cur_item).attr('id');
                    var cardContents = ""
                    +"<div class='card text-body bg-primary mb-3 mx-auto mt-2' style='max-width:80rem' id='"+curId+"'>"
                    +"<div class='card-header container-fluid'>"
                       +" <div class='row'>"
                            +"<div class='mr-auto'>"
                                +"<span class='bi bi-trash-fill cls-btn' id='"+ curId +"' onClick='remove(this)'> </span>"
                                +"<span class='bi bi-pencil-fill cls-btn' id='"+ curId +"' onClick='edit(this)'> </span>"
                                +"<span class='post-id'> " + curId.substring(1) + "</span>"
                                +"<span class='coopdisp'> " + $(cur_item).find('entry > title').text() + "</span>"
                                +"<div class='float-right'><span class='body-primary'>" + $(cur_item).find('entry > published').text() + "</span></div>"
                            +"</div>"
                            +"</div>"
                        +"</div>"
                        +"<div class='card-body' id='"+ curId +"'><div class='stn-body' id='"+ curId +"'><textarea disabled='disabled' class='form-control cls-post' id='"+curId+"' rows='5'>"+$(cur_item).find('body').text()+"</textarea></div>"
                        +"</div>";
                    console.log(cardContents);
                    $(stream).prepend(cardContents);
                });
                $(stream).prependTo('#stream');
                $(document).trigger('list');
            }
        }
        return true;
    },
    handle_message: function (message) {
        if ($(message).attr('from').match(/^pubsub\.coopslake\.solutions$/)){
            if ($(message).find('items').attr('node').match('blog/'+$('#zone').val())){
            var delayed = $(message).find('delay').length > 0;
            var body = $(message).find('event > items').contents();
            var messagebody = marked.parse($(message).find("entry > body").text())
            console.log("got it");
            console.log(message);
            var div = $("<div></div>");
            var messagebody = marked.parse($(message).find("entry > body").text());
            var div1 = $build('div',{'class':'card text-body bg-primary mb-3 mx-auto mt-2','style':'max-width:80rem;'})
                .c('div',{'class':'card-header container-fluid'})
                    .c('div',{'class':'row'})
                        .c('div',{'class':'col-md-9'})
                            .c('span',{'class':'coopdisp'},"D E " + $(message).find("items > item").attr('id') + " " + $(message).find("entry > title").text())
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
function edit(i) {
    var at = "textarea#"+$(i).attr('id')+".form-control.cls-post";
    var ta = document.querySelector(at);
    console.log(ta);
    if (ta.getAttribute('disabled','disabled')){
      ta.removeAttribute('disabled');
      i.classList.add('cls-btn-toggled');
    } else {
      ta.setAttribute('disabled','disabled');
      i.classList.remove('cls-btn-toggled')
    }
  return true;
    //$("div#"+id+".stn-body").toggleClass("hidden");
}
function remove(i) {
    Arthur.retract_item($(i).attr('id'),$("#zone").val());
    alert("delete: "+$(i).attr('id'));
}
$(document).ready(function () {
  // old way of dialog
    // $('#login_dialog').dialog({
    //     autoOpen: true,
    //     dragable: true,
    //     modal: true,
    //     title: 'Login to Administration',
    //     buttons: {
    //         "Connect": function () {
    //             $(document).trigger('connect', {
    //                 jid: $('#jid').val(),
    //                 password: $('#password').val()
    //             });
    //             $('password').val('');
    //             $(this).dialog('close');
    //         }
    //     }
    // });
    //
    $(".bi-type-bold").click(function (ev) {
      console.log(ev);
      var usersel;
      if (window.getSelection) {
        console.log("method 1");
        usersel = window.getSelection();  
      } else if (document.selection){
        console.log("method 2");
        usersel = document.selection.createRange().text;
      }
      console.log(usersel);
    });
  //new way of dialog
    $('#test-dg').modal('show');
    $('#cls-btn-login').click(function () {
        $(document).trigger('connect', {
          jid: $('#jid').val(),
          password: $('#password').val()
        });
      $('#test-dg').modal('hide');
    });
    $('#input').keyup(function () {
        var left = 250 - $(this).val().length;
        $('#coutner .count').text(''+left);
    });
    $('#cls-btn-post').click( function(ev){
        var d = new Date();
        Arthur.connection.sendIQ($iq({to:"pubsub.coopslake.solutions",
                        type:"set",
                        from:"blog@coopslake.solutions"})
        .c('pubsub',{xmlns:"http://jabber.org/protocol/pubsub"})
        .c('publish',{node:"blog/home"})
        .c('item')
        .c('entry',{xmlns:"http://www.w3.org/2005/Atom"})
        .c('title').t($('#cls-title').val())
        .up().c('body').t($('#cls-post').val())
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
    // Arthur.connection.addHandler(Arthur.handle_message,
    //                             null,
    //                             "message",
    //                             "headline"
    //                         );
    Arthur.connection.addHandler(Arthur.handle_list,
                                null,
                                "iq",
                                "result"
                            );
    Arthur.connection.send($pres().c('priority').t('-1'));
    Arthur.request_items($("#zone").val(),0);
});
$(document).bind('list', function (){
  var snpButtons = "<div><span class=\"btn btm-primary bi bi-pencil-fill\">Edit</span><span class=\"btn btn-primary bi bi-envelope-arrow-up\">New Post</span><span class=\"bi bi-images btn btn-primary\">Images</span></div>"
  $('#btn-pallete').html(snpButtons);
  
  $('.bi-envelope-arrow-up').click(function(){
    $(document).trigger('newpostwanted');
  });
  $('.bi-images').click(function (e) {
    console.log('images');
    $('#cls-btn-post').click(function () {
      console.log('post clicked');
    });
    $('#images-dg').modal('show');
  });
});


$(document).bind('newpostwanted', function (ev, data) {
   $("#post-dg").modal('show');
});

$(document).bind('send_post', function (ev, data){
  console.log(data);
});

$(document).bind('disconnected', function () {
    // placeholder
});
