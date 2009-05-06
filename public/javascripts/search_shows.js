$(function() {
  jQuery(document).ready(function($) {
		$('#search_form_shows').ajaxForm({
		   beforeSubmit: displayLoadingImage,			
			 success: clearSearchButtons,
		 	 target: '#search_accordion_shows'
		});
		$('#paginate_form_shows').ajaxForm({
		   beforeSubmit: displayLoadingImage,			
		 	 target: '#search_accordion_shows'
		});
	  $('div.paginated a').livequery('click', function() {
      displayLoadingImage();   
		  $.ajax({
			  type: "POST",
			  url:  this.href,
			  success: function(msg) {
				  $('#search_accordion_shows').html(msg);
			  }	
		  })
	    return false;
	  });
	  $('#recording_details_shows').livequery('click', function() {
			$("div[id*='dialog_rec']").dialog('close');
			$("div[id*='dialog_setlist']").dialog('close');	
			displayLoadingImage();	
		  $.ajax({
			  type: "POST",
			  url:  this.href,
			  success: function(msg) {
				  $('#search_accordion_shows').html(msg);
			  }	
		  })	   
	    return false;
	  });						
	});		
	function clearSearchButtons(responseText, statusText)  { 
	    $('#search_buttons_shows').empty();
	}	
	function displayLoadingImage() {
		$('#search_accordion_recordings').html('<p><br><br><br><br><br><img src="/images/loading_bar.gif" width="220" height="19" /><br><br><br><br><br></p>');
	}	
});		