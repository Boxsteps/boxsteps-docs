/************* Backstretch jQuery (slideshow Bg images) ****************/
$(document).ready(function() {

	$.backstretch([
		"images/background-slideshow/slide-1.jpg",
		"images/background-slideshow/slide-2.jpg",
		"images/background-slideshow/slide-3.jpg"
		], {
		fade: 3000,
		duration: 5000
		}
	);
});