$(function() {
  jQuery(document).ready(function($) {	
		/*$("input[id*='song_id']").autocomplete("/songs/list",{
			max: 15,
			multiple: true,
			multipleSeparator: ", ",
      parse: function(data) {
          var rows = new Array();
          for(var i=0; i<data.length; i++){
              rows[i] = { data:data[i], value: '' + data[i].id, result:data[i].label };
          }
          return rows;
      },
      formatItem: function(row, i, n) {
          return row.label;
      }
		}).result(function(event, item) {
				  $("[name=" + this.id + "]").val($("[name=" + this.id + "]").attr("value") + "," + item.id);	
					alert($("[name=" + this.id + "]").attr("value"));
		});	
		$("input[id*='song_name']").autoSuggest("/songs/list", {
			selectedItemProp: "label", 
			selectedValuesProp: "id", 
			searchObjProps: "label",
			preFill: "/tracks/#{@recording.id}/1"
		}); */
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
					$("#dialog").html(html);
					$("#dialog").dialog();
				});			
			}
		});	
    $.fn.select_show = function(show_id){
	    $("#dialog").dialog("close");
	    $("#show_id").val(show_id);
		}
		$("#discs").change(function() {
			$("#tracks").html("<br>");
			for (var i=1; i<=$("#discs").selectedValues(); i++) {
				$("#tracks").append("<h5>Disc " + i + " Track Count:&nbsp;&nbsp;&nbsp;<input size='2' type='text' name='tracksDisc" + i + "'/></h5>");
			}
		});
  });		
});