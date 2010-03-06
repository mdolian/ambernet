$(function() {
  jQuery(document).ready(function($) {
  	$("#nav ul li a").corner();
		$('.anythingSlider').anythingSlider({
		        easing: "swing",                
		        hashTags: true,                 // Should links change the hashtag in the URL?
		        buildNavigation: true,          // If true, builds and list of anchor links to link to each slide
		});	
  });		
});