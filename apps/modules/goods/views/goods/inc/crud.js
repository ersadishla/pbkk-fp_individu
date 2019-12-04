function addGoods() {
    save_method = "add";
    $('input[name=_method]').val('POST');
    $('#modal-form').modal('show');
    $('#modal-form form')[0].reset();
    $('.modal-title').text('Tambah Barang');
    $('#brand_id').prop("disabled", false).trigger('change').select2('val', '');
    $('#name').prop("disabled", false);
    $('#type').prop("disabled", false);
    $('#volume').prop("disabled", false).number(true, null, ',', '.');
    $('#stock').prop("disabled", false).number(true, null, ',', '.');
    $('#min_stock').prop("disabled", false).number(true, null, ',', '.');
    $('#last_purchase_price').prop("disabled", false).number(true, null, ',', '.');
}

function editGoods(id) {
    save_method = 'edit';
    $('input[name=_method]').val('PATCH');
    $('#modal-form form')[0].reset();
    $.ajax({
        url: "{{ url('goods') }}" + '/' + id + "/edit",
        type: "GET",
        dataType: "JSON",
        success: function(data) {
            console.log(data);
            $('#modal-form').modal('show');
            $('.modal-title').text('Edit Barang');
            $('#id').val(data.id);
            $('#brand_id').val(data.brand_id).prop("disabled", false);
            $('#brand_id').trigger('change'); 
            $('#name').val(data.name).prop("disabled", false);
            $('#type').val(data.type).prop("disabled", false);
            $('#volume').val(data.volume).prop("disabled", false);
            $('#stock').val(data.stock).prop("disabled", true);
            $('#min_stock').val(data.min_stock).prop("disabled", false);
            $('#last_purchase_price').val(data.last_purchase_price).prop("disabled", true);
        },
        error : function(data) {
            $.each(data.errors, function(key, value){
                $('.alert-danger').show();
                $('.alert-danger').append('<p>'+ value +'</p>');
            });
            setTimeout(function() { 
                $('.alert-danger').empty().hide();
            }, 5000)
        }
    });
}

function deleteGoods(id) {
    save_method = 'delete';
    $('input[name=_method]').val('DELETE');
    $('#modal-form form')[0].reset();
    $.ajax({
        url: "{{ url('goods') }}" + '/' + id + "/edit",
        type: "GET",
        dataType: "JSON",
        success: function(data) {
            $('#modal-form').modal('show');
            $('.modal-title').text('Hapus Barang');
            $('#id').val(data.id);
            $('#brand_id').val(data.brand_id);
            $('#brand_id').trigger('change').prop("disabled", true);
            $('#supplier').val(data.supplier_id);
            $('#supplier').trigger('change').prop("disabled", true);  
            $('#name').val(data.name).prop("disabled", true);
            $('#type').val(data.type).prop("disabled", true);
            $('#volume').val(data.volume).prop("disabled", true);
            $('#stock').val(data.stock).prop("disabled", true);
            $('#min_stock').val(data.min_stock).prop("disabled", true);
            $('#last_purchase_price').val(data.last_purchase_price).prop("disabled", true);
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
    $('#brand_id-error').html("");
    $('#name-error').html("");
    $('#type-error').html("");
    $('#volume-error').html("");
    $('#stock-error').html("");
    $('#min_stock-error').html("");
    $('#last_purchase_price-error').html("");
    let id = $('#id').val();

    if (save_method == 'add'){
        url = "{{ url('goods') }}";
        type = "POST";
        data = $("#modal-form form").serialize();
    }
    else if(save_method == 'edit'){
        url = "{{ url('goods') }}" + '/' + id + "/update";
        type = "POST";
        data = $("#modal-form form").serialize();
    }
    else if(save_method == 'delete'){
        url = "{{ url('goods') }}" + '/' + id + "/destroy";
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
                if(data.errors.brand_id){
                    $('#brand_id-error').html( data.errors.brand_id );
                }
                if(data.errors.name){
                    $('#name-error').html( data.errors.name );
                }
                if(data.errors.type){
                    $('#type-error').html( data.errors.type );
                }
                if(data.errors.volume){
                    $('#volume-error').html( data.errors.volume );
                }
                if(data.errors.stock){
                    $('#stock-error').html( data.errors.stock );
                }
                if(data.errors.min_stock){
                    $('#min_stock-error').html( data.errors.min_stock );
                }
                if(data.errors.last_purchase_price){
                    $('#last_purchase_price-error').html( data.errors.last_purchase_price );
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