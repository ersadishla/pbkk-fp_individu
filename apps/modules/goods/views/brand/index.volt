{% extends '../layouts/app.volt' %}

{% block content %}
<div class="d-flex justify-content-between">
    <h1 class="h3 mb-2 text-gray-800">Daftar Merk</h1>
</div>
<hr>
<div class="card shadow mb-4">
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-bordered" id="brand-table" width="100%" cellspacing="0">
                <div class="alert alert-danger" style="display:none"></div>
                <div class="alert alert-success" style="display:none"></div>
                <div class="d-flex justify-content-end">
                    <a href="#" onclick="addBrand()" class="btn btn-primary">
                        Tambah
                    </a>
                </div>
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Nama</th>
                        <th>Aksi</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="modal fade" id="modal-form">
    <div class="modal-dialog">
        <div class="modal-content">
            <form  method="post" class="form-horizontal" data-toggle="validator">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h2 class="modal-title font-weight-bold"></h2>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                
                <!-- Modal body -->
                <div class="modal-body">
                    <input type="hidden" id="id" name="id">
                    <div class="form-group row">
                        <label for="name" class="col-md-3 col-form-label text-md-right">Nama</label>

                        <div class="col-md-7">
                            <input id="name" type="text" class="square form-control" name="name" autofocus>
                            <span class="text-danger">
                                <small id="name-error"></small>
                            </span>
                        </div>
                    </div>
                </div>
                
                <!-- Modal footer -->
                <div class="modal-footer">
                    <div class="col-md-9 offset-md-3">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">
                            Kembali
                        </button>
                        <button type="button" class="btn btn-primary" id="form-submit">
                            Submit
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

{% endblock %}

{% block js %}
<script>
    $(document).ready(function(){
        $('[data-toggle="tooltip"]').tooltip();   
    });
    
    let table = 
    $('#brand-table').DataTable({
        order: [[1, 'asc']], 
        processing: true,
        serverSide: true,
        ajax: "{{ url('brand') }}",
        columns: [
            {data: 'id', render: function (data, type, row, meta) {
                return meta.row + meta.settings._iDisplayStart + 1;
            } },
            {data: 'name', name: 'name'}
            // {data: 'action', name: 'action', orderable: false, searchable: false}
        ],
        columnDefs: [{
            targets: [2],
            "render": function (data, type, row, meta) {
                return '<a onclick="editBrand('+ row.id +')" class="btn btn-info btn-sm text-white"> Edit</a> ' +
                        '<a onclick="deleteBrand('+ row.id +')" class="btn btn-danger btn-sm text-white"> Delete</a>';
            }
		}]
    });

    function addBrand() {
        save_method = "add";
        $('#modal-form').modal('show');
        $('#modal-form form')[0].reset();
        $('.modal-title').text('Tambah Merk');
        $('#name').prop("disabled", false);
    }

    function editBrand(id) {
        save_method = 'edit';
        $('#modal-form form')[0].reset();
        $.ajax({
            url: "{{ url('brand') }}" + '/' + id + "/edit",
            type: "GET",
            dataType: "JSON",
            success: function(data) {
                console.log(data);
                $('#modal-form').modal('show');
                $('.modal-title').text('Edit Merk');
                $('#id').val(data.id);
                $('#name').val(data.name).prop("disabled", false);
            },
            error : function(data) {
                console.log('error');
                console.log(data);
                $.each(data.errors, function(key, value){
                    $('.alert-danger').show();
                    $('.alert-danger').append('<p>'+ value +'</p>');
                });
                setTimeout(function() { 
                    $('.alert-danger').empty().hide();
                }, 3000)
            }
        });
    }

    function deleteBrand(id) {
        save_method = 'delete';
        $('#modal-form form')[0].reset();
        $.ajax({
            url: "{{ url('brand') }}" + '/' + id + "/edit",
            type: "GET",
            dataType: "JSON",
            success: function(data) {
                $('#modal-form').modal('show');
                $('.modal-title').text('Anda yakin ingin menghapus Merk');
                $('#id').val(data.id);
                $('#name').val(data.name).prop("disabled", true);
            },
            error : function(data) {
                $.each(data.errors, function(key, value){
                    $('.alert-danger').show();
                    $('.alert-danger').append('<p>'+ value +'</p>');
                });
                setTimeout(function() { 
                    $('.alert-danger').empty().hide();
                }, 3000)
            }
        });
    }

    $('body').on('click', '#form-submit', function(){
        $('#form-submit').prop('disabled', true);
        $( '#name-error' ).html( "" );
        let id = $('#id').val();

        if (save_method == 'add'){
            url = "{{ url('brand') }}";
            type = "POST";
            data = $("#modal-form form").serialize();
        }
        else if(save_method == 'edit'){
            url = "{{ url('brand') }}" + '/' + id + "/update";
            type = "POST";
            data = $("#modal-form form").serialize();
        }
        else if(save_method == 'delete'){
            url = "{{ url('brand') }}" + '/' + id + "/destroy";
            type = "POST";
            data = $("#modal-form form").serialize();
        }

        $.ajax({
            url: url,
            type: type,
            data: data,
            success:function(data) {
                console.log('sukses');
                console.log(data);
                if(data.errors) {
                    if(data.errors.name){
                        $( '#name-error' ).html( data.errors.name );
                    }
                    $('#form-submit').prop('disabled', false);
                }
                if(data.success) {
                    $('#modal-form').modal('hide');
                    $('#form-submit').prop('disabled', false);
                    table.ajax.reload( null, false );
                    Swal.fire({
                        title: "Sukses!",
                        html:   '<p>' + data.success + '</p>',
                        type: "success",
                        timer: 2000
                    });
                }
            },
            error:function(data){
                console.log('error');
                console.log(data);
            }
        });
    });
</script>
{% endblock %}