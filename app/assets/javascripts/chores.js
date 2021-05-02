this.edit_chore_submit = function(id) {
  document.getElementById("edit_chore_" + id).submit();
};

this.create_chore_submit = function() {
  document.getElementById("new_chore").submit();
};

this.adjust_chore_delete_path = function(path, name) {
  document.getElementById("chore-name").innerHTML = " " + name;
  var form = document.getElementById("remove_chore");
  if (form !== null) {
    form.action = path;
  }
};
