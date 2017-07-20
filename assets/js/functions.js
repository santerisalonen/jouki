$(document).ready(function() {
   $('.marked').each(function() {
       console.log( $(this).html() );
      $(this).html( marked( $(this).html() ) ); 
   });
    
});