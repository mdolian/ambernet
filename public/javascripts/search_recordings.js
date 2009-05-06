$(function() {
  jQuery(document).ready(function($) {
		$('#search_form_recordings').ajaxForm({
			 success: clearSearchButtons,
		 	 target: '#search_accordion_recordings'
		});
		$('#paginate_form_recordings').ajaxForm({
		 	 target: '#search_accordion_recordings'
		});	
	  $('div.paginated a').livequery('click', function() {
	    $('#search_accordion_recordings').load(this.href);
	    return false;
	  });
	  $('#recording_details').livequery('click', function() {
	    $('#search_accordion_recordings').load(this.href);
	    return false;
	  });				
	});	
	function clearSearchButtons(responseText, statusText)  { 
	    $('#search_buttons_recordings').empty();
	}	
});