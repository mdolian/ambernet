/* NICE SELECT Plugin */
/*
* jQuery NICE SELECT Plugin 
* v1.0
* Author: Dragos Badea (bedeabza@gmail.com)
*
* replaces regular "select" elements with totally customizable html ui components
*/
(function($){
	// plugin definition
	$.fn.niceSelect = function (options){
		var options = $.extend({}, $.fn.niceSelect.defaults, options);
		return this.each(function(){
			var $this = $(this);
			var idu = $this.attr("rel");
			$this.hide();
			$this.after('<input type="hidden" class="'+$this[0].className.replace('nice', '')+'" name="'+$this[0].name+'" value="'+$this.val()+'" />');
			$this.before('<input type="text" class="'+options.virtualInputClass+'" readonly="readonly" id="select'+idu+'" rel="'+$(this).val()+'" value="'+$this[0].options[$this[0].selectedIndex].text+'" />');
			var opts_obj = document.createElement("UL");
			$(opts_obj).addClass(options.virtualSelectClass);
			var option = null;
			for(var i=0;i<$this[0].options.length;i++){
				option = document.createElement("LI");
				$(option).attr("rel",$this[0].options[i].value);
				$(option).html($this[0].options[i].text);
				if(i==$this[0].options.length-1)
					$(option).addClass(options.lastClass);
				if($(option).attr("rel")==$this.val())
					$(option).addClass(options.selectedClass);
				opts_obj.appendChild(option);
			}
			$("#select"+idu).after(opts_obj);
			$this.remove();
			$("li", opts_obj).hover(
				function(){$(this).addClass(options.overClass);},
				function(){$(this).removeClass(options.overClass);}
			).click(function(){
				var $this = $(this);
				$this.parent().hide();
				$this.parent().prev().val($this.html());
				$this.parent().next().val($this.attr("rel"));
				$this.siblings("li").removeClass(options.selectedClass);
				$this.addClass(options.selectedClass);
				if(options.selectCallback!=null){
					var arguments = [{text: $this.html(), value: $this.attr("rel")},$this.parent()];
					options.selectCallback.apply(this, arguments);
				}
				return false;
			});
			$("#select"+idu).click(function(){
				var $this = $(this);
				$("."+options.virtualSelectClass).not($this.next()).hide();
				$this.next("ul").toggle();
				if($this.next("ul").css("display")!="none" && options.openCallback!=null){
					var arguments = [$this, $this.next("ul")];
					options.openCallback.apply(this, arguments);
				}
				return false;
			});
			$("body").click(function(){$("."+options.virtualSelectClass).hide();});
		});
	}
	// plugin defaults
	$.fn.niceSelect.defaults = {
		selectedClass: "selected", //class for the selected item
		overClass: "over", //class for hover items
		virtualSelectClass: "virtual_select", //class for the virtual select (ul)
		virtualInputClass: "nice_select", //class for the textfield item that displays the selected value
		lastClass: "last", //class for the last element of the list
		selectCallback: null, //callback function | equivalend to "onchange" in html | @params: 1 - JSON obj containing value and text 2 - the UL jquery object targeted
		openCallback: null //callback function | executed when the user clicks on the virtual select and the list of options are opened  | @params: 1 - The textbox placeholder for select 2 - the UL jquery object targeted
	};
})(jQuery);