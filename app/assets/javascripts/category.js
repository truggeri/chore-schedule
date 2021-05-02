this.create_category_submit = function() {
  document.getElementById("new_category").submit();
};

this.adjust_category_delete_path = function(path, name) {
  document.getElementById("category-name").innerHTML = " " + name;
  var form = document.getElementById("remove_category");
  if (form !== null) {
    form.action = path;
  }
};
