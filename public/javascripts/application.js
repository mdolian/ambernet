$(function() {
  jQuery(document).ready(function($) {	
		$("#venue_name").autocomplete("/venues/list");
		$("#venue_city").autocomplete("/venues/city_list");	
    $("#mycarousel").jcarousel({
	    scroll: 1,
	    visible: 1,
      initCallback: mycarousel_initCallback	
 		});
    $("table") 
      .tablesorter({widthFixed: true, widgets: ['zebra']});
    $.fn.select_show = function(show_id){
	    $("#dialog").dialog("close");
	    $("#show_id").val(show_id);
		}
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
			  $(that).dialog();
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
			  $(that).dialog();
			});							
		}		
		$('#show_date_played').datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth: true,
			changeYear: true,	
			showOn: 'button', 
			buttonImage: '../images/calendar.gif', 
			buttonImageOnly: true,		
			onSelect: function(){
				$.getJSON("/shows/list", {date_played: $('#show_date_played').val()}, function(json){
					html = "";
					$.each(json, function(i, item) {
					  html += "<a href='#' id='show_link' onclick='$(this).select_show(" + item.id + ")'>";
					  html += item.label;
					  html += "</a>";
					});
					$("#dialog").dialog();
					$("#dialog").html(html);
				});			
			}
		});				
  });		
});

function mycarousel_initCallback(carousel) {
    jQuery('.jcarousel-control a').bind('click', function() {
        carousel.scroll(jQuery.jcarousel.intval(jQuery(this).attr("id")));
        return false;
    });
}