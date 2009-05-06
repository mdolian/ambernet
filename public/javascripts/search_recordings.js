$(function() {
  jQuery(document).ready(function($) {
		$('#search_form_recordings').ajaxForm({
		   beforeSubmit: displayLoadingImage,
			 success: clearSearchButtons,
		 	 target: '#search_accordion_recordings'
		});
		$('#paginate_form_recordings').ajaxForm({
		   beforeSubmit: displayLoadingImage,			
		 	 target: '#search_accordion_recordings'
		});	
	  $('div.paginated a').livequery('click', function() {
			displayLoadingImage();
		  $.ajax({
			  type: "POST",
			  url:  this.href,
			  success: function(msg) {
				  $('#search_accordion_recordings').html(msg);
			  }	
		  })
	    return false;
	  });
	  $('#recording_details').livequery('click', function() {
			displayLoadingImage();
		  $.ajax({
			  type: "POST",
			  url:  this.href,
			  success: function(msg) {
				  $('#search_accordion_recordings').html(msg);
			  }	
		  })		
	    return false;
	  });				
	});	
	function clearSearchButtons()  { 
	  $('#search_buttons_recordings').empty();
	}
	function displayLoadingImage() {
		$('#search_accordion_recordings').html('<p><br><br><br><br><br><img src="/images/loading_bar.gif" width="220" height="19" /><br><br><br><br><br></p>');
	}
});