$(function() {
  jQuery(document).ready(function($) {
		$("#venue_name").autocomplete("/venues/list");
		$("#venue_city").autocomplete("/venues/city_list");	
		$('#start_date').datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth: true,
			changeYear: true	
		});	
		$('#end_date').datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth: true,
			changeYear: true
		});	
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
	  $('#back').livequery('click', function() {
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