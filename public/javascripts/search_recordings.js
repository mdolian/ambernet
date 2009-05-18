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
		 	 target: '#main_recordings'
		});	
		$('#paginate_form_recordings').ajaxForm({
		   beforeSubmit: displayLoadingImage,			
		 	 target: '#main_recordings'
		});	
	  $('div.paginated a').livequery('click', function() {
			displayLoadingImage();
		  $.ajax({
			  url:  this.href,
			  success: function(msg) {
				  $('#main_recordings').html(msg);
			  }	
		  })
	    return false;
	  });
	  $("a[id*='recording_details_rec']").livequery('click', function() {
			displayLoadingImage();
		  $.ajax({
			  url:  this.href,
			  success: function(msg) {
				  $('#main_recordings').html(msg);
			  }	
		  })		
	    return false;
	  });
	  $("#reload_rec").livequery('click', function() {
			displayLoadingImage();
		  $.ajax({
			  url:  this.href,
			  success: function(msg) {
				  $('#search_accordion_recordings').html(msg);
			  }	
		  })		
	    return false;
	  });		
	  $('#zip_link_mp3').livequery('click', function() {
		  $.ajax({
				url: '/recordings/zip/' + $('#recording_id').html()  + '/mp3',
				success: function(msg) {
					$('#zip_mp3').html(msg);
				}			
			})
			var m = setInterval(function() {
		     $('#zip_mp3').load('/recordings/zip_link/' + $('#recording_id').html() + '/mp3');
		     alert($('#status_mp3').html());
		     if($('#status_mp3').html() == null || $('#status_mp3').html() == "") {
			   } else {
			     alert("stopping");
					 clearInterval(m);			
		     }
		  }, 30000);	
	    return false;
	  });	
	  $('#zip_link_lossless').livequery('click', function() {
		  $.ajax({
				url: '/recordings/zip/' + $('#recording_id').html()  + '/lossless',
				success: function(msg) {
					$('#zip_lossless').html(msg);
				}
			})
			var l = setInterval(function() {
		     $('#zip_lossless').load('/recordings/zip_link/' + $('#recording_id').html() + '/lossless');
		     alert($('#status_lossless').html());
		     if($('#status_lossless').html() == null || $('#status_lossless').html() == "") {
			   } else {
			     alert("stopping");
					 clearInterval(l);			
		     }		  
		  }, 60000);
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
	function clearSearchButtons()  { 
	  $('#search_buttons_recordings').empty();
	}
	function displayLoadingImage() {
		$('#main_recordings').html('<p><br><br><br><br><br><img src="/images/loading_bar.gif" width="220" height="19" /><br><br><br><br><br></p>');
	}	
});