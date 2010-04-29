$(function() {
  jQuery(document).ready(function($) {

		$("#main-nav li a.main-link").hover(function(){
			$("#main-nav li a.close").fadeIn();
			$("#main-nav li a.main-link").removeClass("active");												 
			$(this).addClass("active");										 
			$("#sub-link-bar").animate({
				height: "40px"					   
			});
			$(".sub-links").hide();
			$(this).siblings(".sub-links").fadeIn();
		});
		
		$("#main-nav li a.close").click(function(){
			$("#main-nav li a.main-link").removeClass("active");												 									 
			$(".sub-links").fadeOut();
			$("#sub-link-bar").animate({
				height: "10px"					   
			});		
			$("#main-nav li a.close").fadeOut();
		});

  	$('#browse_tabs').tabs();		

		$('#delete').click(function() {
		  return true;
		})
		
		$('#delete').confirm();

		$("div[id*='accordion']").accordion({
			autoHeight: false
		});
		
		$("#venue_name").autoSuggest("/venues/list", {
			startText: "Enter Venues",
			selectedItemProp: "label",
			selectedValuesProp: "id",
			asHtmlID: "venues",
			searchObjProps: "label"
		});

		$("#venue_city").autoSuggest("/venues/city_list", {
			startText: "Enter City",
			selectedItemProp: "label",
			selectedValuesProp: "label",
			asHtmlID: "cities",
			searchObjProps: "label",
			selectionLimit: 1
		});
		
		$("#song_name").autoSuggest("/songs/list", {
			startText: "Enter Songs",
			selectedItemProp: "label",
			selectedValuesProp: "id",
			asHtmlID: "songs",
			searchObjProps: "label"
		});		
		
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

	  $("div[id*='dialog_setlist']").dialog({ autoOpen: false, width: 400, modal: true });
		$("#recording_directory").dialog({ autoOpen: false, modal: true });

		$.fn.listing = function(recording_id){
			$.ajax({    
				url: "/recordings/directory/" + recording_id, 
				success: function(msg) {
					$("#recording_directory").html(msg);
					$("#recording_directory").dialog("open");
				}
			})
		}
			
		$.fn.setlist = function(show_id){
			that = this
			var set = new Array();
			$.getJSON("/shows/setlist/" + show_id, function(json){
				set[1] = "<b>Set 1:</b> "
				set[2] = "<b>Set 2:</b> "
				set[3] = "<b>Set 3:</b> "
				set[4] = "<b>Set 4:</b> "
				set[5] = "<b>Set 5:</b> "												
				set[9] = "<b>Encore:</b> "
				total_sets = 0		
				$.each(json, function(i, item) {
					total_sets = item.total_sets
					set[item.set_id] += item.song_name + item.segue;
				});
				html = "<p>"
				for(i=1; i<=total_sets; i++) {
					html += set[i] + "<br/>"
				}
				if(set[9] != "<b>Encore:</b> ") {
				  html += set[9]
				}
				html += "</p>";
			  $(that).html(html);
			  $(that).dialog("open");
			});								
		}
		
    $("tr[id*='recording_list_row']").hide();		
		
		$.fn.recordings = function(show_id){
		  if($("#recording_list_row_" + show_id).is(":visible") == false) {
				$.ajax({
				  url:  "/shows/" + show_id + "/recordings",
				  success: function(msg) {
					  $('#recording_list_' + show_id).html(msg);
	    			$("#recording_list_row_" + show_id).show();
				  }	
			  })
			} else {
				$("#recording_list_row_" + show_id).hide();
			}						
		}
  });	
});