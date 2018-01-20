document.addEventListener("turbolinks:load", function() {
  $('.dropdown').hover(
    function() {
      $('.dropdown-menu', this).stop( true, true ).slideDown('fast');
      $(this).toggleClass('open');
    },
    function() {
      $('.dropdown-menu', this).stop( true, true ).slideUp('fast');
      $(this).toggleClass('open');
    }
  );
  $('#micropost_picture').bind('change', function() {
    var size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > 5) {
      alert(I18n.t("Max_size_picure"));
    }
  });
  $(function () {
    // Replace the <textarea id="editor1"> with a CKEditor
    // instance, using default configuration.
    CKEDITOR.replace('editor1')
    //bootstrap WYSIHTML5 - text editor
    $('.textarea').wysihtml5()
  })
});
