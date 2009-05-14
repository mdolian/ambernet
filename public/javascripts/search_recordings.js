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
	  $('#zip_link_mp3').livequery('click', function() {
		  $('#zip_mp3').empty();
		  $('#zip_mp3').html("Generating...");
			var m = setInterval(function() {
		     $('#zip_mp3').fadeOut("slow").load('/recordings/zip_link/' + $('#recording_id').html() + '/mp3').fadeIn("slow");
		  }, 10000);
		  $.ajax({
			  url:  '/recordings/zip/' + $('#recording_id').html()  + '/mp3',
			  success: function(msg) {
				  $('#zip_mp3').html(msg);
					clearInterval(m);
			  }	
		  })		
	    return false;
	  });	
	  $('#zip_link_lossless').livequery('click', function() {
		  $('#zip_lossless').empty();
		  $('#zip_lossless').html("Generating...");
			var l = setInterval(function() {
		     $('#zip_lossless').fadeOut("slow").load('/recordings/zip_link/' + $('#recording_id').html() + '/lossless').fadeIn("slow");
		  }, 60000);
		  $.ajax({
			  url:  '/recordings/zip/' + $('#recording_id').html()  + '/lossless',
			  success: function(msg) {
				  $('#zip_lossless').html(msg);
					clearInterval(l);
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
	function clearSearchButtons()  { 
	  $('#search_buttons_recordings').empty();
	}
	function displayLoadingImage() {
		$('#main_recordings').html('<p><br><br><br><br><br><img src="/images/loading_bar.gif" width="220" height="19" /><br><br><br><br><br></p>');
	}	
});