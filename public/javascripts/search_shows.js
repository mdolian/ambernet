$(function() {
  jQuery(document).ready(function($) {
		$('#search_form_shows').ajaxForm({
			 success: clearSearchButtons,
		 	 target: '#search_accordion_shows'
		});
		$('#paginate_form_shows').ajaxForm({
		 	 target: '#search_accordion_shows'
		});
	  $('div.paginated a').livequery('click', function() {
	    $('#search_accordion_shows').load(this.href);
	    return false;
	  });
	  $('#recording_details').livequery('click', function() {
	    $('#search_accordion_shows').load(this.href);
	    return false;
	  });						
	});		
	function clearSearchButtons(responseText, statusText)  { 
		  alert("blah");
	    $('#search_buttons').empty();
	}	
});		