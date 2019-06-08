var enable_tooltips, initial_delete_setup;

this.edit_chore_submit = function(id) {
    $('#edit_chore_' + id).trigger("submit");
};

this.create_chore_submit = function() {
    $('#new_chore').trigger("submit");
};

this.adjust_delete_path = function(path, name) {
    $.ajaxSetup({
        url: path
    });
    $('#chore-name').text(" " + name);
};

initial_delete_setup = function() {
    $.ajaxSetup({
        type: 'DELETE',
        headers: {
            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        },
        statusCode: {
            302: function(response) {
                var redirect_url;
                redirect_url = response.getResponseHeader('X-Ajax-Redirect-Url');
                if (redirect_url !== void 0) {
                    window.location.pathname = redirect_url;
                }
            }
        }
    });
};

initial_delete_setup();

this.perform_or_assign_chore = function(path) {
    $.ajaxSetup({
        url: path,
        type: 'GET',
        headers: {
            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        },
        statusCode: {
            302: function(response) {
                var redirect_url;
                redirect_url = response.getResponseHeader('X-Ajax-Redirect-Url');
                if (redirect_url !== void 0) {
                    window.location.pathname = redirect_url;
                }
            }
        }
    });
    $.ajax();
};

enable_tooltips = function() {
    $('[data-toggle="tooltip"]').tooltip();
};

document.addEventListener('turbolinks:load', function() {
    enable_tooltips();
});