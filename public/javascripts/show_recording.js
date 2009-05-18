$(function() {
  jQuery(document).ready(function($) {
		$("#reload_rec").livequery('click', function() {
			displayLoadingImage();
		  $.ajax({
			  url:  this.href,
			  success: function(msg) {
				  $('#main_recordings').html(msg);
			  }	
		  })		
		  return false;
		});		
	  $('#back').livequery('click', function() {
			displayLoadingImage();
		  $.ajax({
			  url:  this.href,
			  success: function(msg) {
				  $('#main_recordings').html(msg);
			  }	
		  })		
	    return false;
	  });		
	});	
	function displayLoadingImage() {
		$('#main_recordings').html('<p><br><br><br><br><br><img src="/images/loading_bar.gif" width="220" height="19" /><br><br><br><br><br></p>');
	}	
});		