$(function() {
	// Highlight Selected Categories
	$("input[type=checkbox]").change( function() {
		if ($(this).is(":checked")) {
			$(this).parent().addClass("highlight");
		} else {
			$(this).parent().removeClass("highlight");
		}
	});
	
	// Fill Latitude/Longitude with selected city
	$("#select_city").change(function() {
		var lonlat = $(this).val().split(",");
		if ( lonlat[0] && lonlat[1] )
		{
			$("#latitude").attr("value", lonlat[1]);
			$("#longitude").attr("value", lonlat[0]);
			$("#location_name").attr("value", $('#select_city :selected').text());
		}
	});
	
	$("#category-column-1,#category-column-2").treeview({
        persist: "location",
        collapsed: true,
        unique: false
	});
});