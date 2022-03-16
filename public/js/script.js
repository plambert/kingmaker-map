$(document).ready(function() {
   
   $('.hex').each(function(index) {
    var esplo = $(this).attr('explored');
  var evento = $(this).attr('eventtype');
  if(esplo == 'no'){
    $(this).children().fadeTo( 1000, 0 );
    $(this).css('background-image','url(images/notexplored.png)');
    $(this).css('background-repeat','no-repeat');
    $(this).css('background-position','center');
  } 
  
  if(esplo == 'yes'){
    if(evento === undefined){
          $(this).children().fadeTo( 1000, 0 );
        } else {
          $(this).children().fadeTo( 1000, 0 );
               $(this).attr( 'explored', 'yes' );
               $(this).css('background-image','url(images/'+evento+'.gif)');
               $(this).css('background-repeat','no-repeat');
               $(this).css('background-position','center');
               $(this).css('background-size','30%');
               $(this).children('.text').fadeTo(1000,1);
               $(this).children('.text').text($(this).attr('eventname'));
        }
    
  }    

  });


 //   $(".hex").click(function() {
 //     var esplo = $(this).attr('explored');
 //     if(esplo === undefined){
 //       var r = confirm("Reveal hex?");
  //    if (r == true) {
 //            $(this).attr( 'explored', 'no' )
 //            $(this).children().fadeTo( 1000, 0 );
 //            $(this).css('background-image','url(images/notexplored.png)');
  //         $(this).css('background-repeat','no-repeat');
  //         $(this).css('background-position','center');
  //         $.get("/hexstatus/"+$(this).attr('row')+"/"+$(this).attr('tile')+"/no");
  //    }
  //  }else{
  //    if(esplo == 'no'){
  //      var r = confirm("Mark hex fully explored?");
  //      var evento = $(this).attr('eventtype');
  //      if(evento === undefined){
  //        $(this).css('background-image','');
  //        // alert("non c'è nulla");
  //        $(this).attr( 'explored', 'yes' );
  //        $.get("/hexstatus/"+$(this).attr('row')+"/"+$(this).attr('tile')+"/yes");
  //      } else {
  //        if (r == true) {
  //             $(this).attr( 'explored', 'yes' );
  //             $(this).css('background-image','url(images/'+evento+'.gif)');
  //             $(this).css('background-repeat','no-repeat');
  //             $(this).css('background-position','center');
  //             $(this).css('background-size','30%');
  //             $(this).children('.text').fadeTo(1000,1);
  //             $(this).children('.text').text($(this).attr('eventname'));
  //             $.get("/hexstatus/"+$(this).attr('row')+"/"+$(this).attr('tile')+"/yes");
  //        }
  //      }
  //    }
  //  }

  // });



  // $("#reset").click(function() {
  //  $('.hex').each(function(index) {
  //    $(this).css('background-image','');
  //    $(this).removeAttr('explored');
  //    $(this).children().fadeTo( 1000, 1 );
  //    $(this).children('.text').text($(this).attr('row')+"-"+$(this).attr('tile'));
  //    $.get("/hexstatus/"+$(this).attr('row')+"/"+$(this).attr('tile')+"/reset");
  //  });
  // });

  // $("#unveil").click(function() {
  //  $('.hex').each(function(index) {
  //    var evento = $(this).attr('eventtype');
  //    $(this).children().fadeTo( 1000, 0 );
  //      if(evento === undefined){
  //        $(this).css('background-image','');
  //        $(this).attr( 'explored', 'yes' );
  //        $.get("/hexstatus/"+$(this).attr('row')+"/"+$(this).attr('tile')+"/yes");
  //      } else {
  //             $(this).attr( 'explored', 'yes' );
  //             $(this).css('background-image','url(images/'+evento+'.gif)');
  //             $(this).css('background-repeat','no-repeat');
  //             $(this).css('background-position','center');
  //             $(this).css('background-size','30%');
  //             $(this).children('.text').fadeTo(1000,1);
  //             $(this).children('.text').text($(this).attr('eventname'));
  //             $.get("/hexstatus/"+$(this).attr('row')+"/"+$(this).attr('tile')+"/yes");
  //      }
  //  });
  // });


  
 });
