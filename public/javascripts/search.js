$(function() {
  jQuery(document).ready(function($) {	
		$("#venue_name").autocomplete("/venues/list");
		$("#venue_city").autocomplete("/venues/city_list");	
    $("#carousel_block").cycle({
	    fx:     'scrollHorz', 
	    speed:  'fast',
	    prev:   '#prev',
	    next:   '#next',
	    after:   onAfter,
	    pager:  '#carousel-control',
	    timeout: 0,
		  containerResize: true,
      pagerAnchorBuilder: function(idx, slide) {
          return '#carousel-control a:eq(' + (idx) + ')';
      }
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
  });		
});

function onAfter(curr, next, opts) {
    var index = opts.currSlide;
    jQuery('#prev')[index == 0 ? 'hide' : 'show']();
    jQuery('#next')[index == opts.slideCount - 1 ? 'hide' : 'show']();
}