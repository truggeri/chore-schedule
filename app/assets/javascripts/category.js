var initial_category_delete_setup;

this.create_category_submit = function() {
  $("#new_category").trigger("submit");
};

this.adjust_category_delete_path = function(path, name) {
  $.ajaxSetup({
    url: path
  });
  $("#category-name").text(" " + name);
};

initial_category_delete_setup = function() {
  $.ajaxSetup({
    type: "DELETE",
    headers: {
      "X-CSRF-Token": $('meta[name="csrf-token"]').attr("content")
    },
    statusCode: {
      302: function(response) {
        var redirect_url;
        redirect_url = response.getResponseHeader("X-Ajax-Redirect-Url");
        if (redirect_url !== void 0) {
          window.location.pathname = redirect_url;
        }
      }
    }
  });
};

initial_category_delete_setup();