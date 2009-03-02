$(function() {
  jQuery(document).ready(function($) {
	  $("div[id*='dialog_setlist']").dialog({ autoOpen: false });
	  $("div[id*='dialog_rec']").dialog({ autoOpen: false });	
		$("table") 
		  .tablesorter({widthFixed: true, widgets: ['zebra']});		
		$.fn.setlist = function(show_id){
			that = this
			$.getJSON("/shows/setlist/" + show_id, function(json){
				set1 = "<b>Set 1:</b> ";
				set2 = "<b>Set 2:</b> ";
				set3 = "<b>Set 3:</b> ";
				encore = "<b>Encore:</b> ";				
				$.each(json, function(i, item) {
					if(item.set_id == "1") {
					  set1 += item.song_name + item.segue;
					}
					if(item.set_id == "2") {
						set2 += item.song_name + item.segue;
					}
					if(item.set_id == "3") {
					  set3 += item.song_name + item.segue;
					}
					if(item.set_id == "9") {
						encore += item.song_name + item.segue;
					}
				});
				html = "<font size'1'>" + set1 + "<br>" + set2 + "<br" + set3 + "<br>" + encore + "</font>";
			  $(that).html(html);
			  $(that).dialog("open");
			});								
		}
		$.fn.recordings = function(show_id){
			that = this; 
			$.getJSON("/shows/recordings/" + show_id, function(json){
				html = "<table><tr><th>Label</th><th>Taper</th><th>Source</th></tr>";
				$.each(json, function(i, item) {
					html += "<td><a href='/recordings/show/" + item.id + "'>" + item.label + "</td>";
					html += "<td>" + item.taper + "</td>";
					html += "<td>" + item.source + "</td>";	
				});
			  $(that).html(html);
			  $(that).dialog("open");
			});							
		}
  });		
});		