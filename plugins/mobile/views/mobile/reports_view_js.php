function initialize() {
    var newsrc = $('#staticmap').attr('src')
        .replace(/size=\d+x\d+/, 'size=' + ($(window).width()-10) + 'x' + ($(window).height()))
        .replace(/zoom=\d+/, 'zoom=15') ;
    $('#staticmap').attr('src', newsrc);
}
