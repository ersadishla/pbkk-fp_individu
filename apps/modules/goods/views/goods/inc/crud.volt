
<div class="modal fade" id="modal-form">
    <div class="modal-dialog">
        <div class="modal-content">
            <form  method="post" class="form-horizontal" data-toggle="validator">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title font-weight-bold"></h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                
                <!-- Modal body -->
                <div class="modal-body">
                    <input type="hidden" name="_method" value="">
                    <input type="hidden" name="_token" value="<?php echo $this->security->getToken() ?>">
                    <input type="hidden" id="id" name="id">
                    <div class="form-group row">
                        <label for="brand" class="col-md-3 col-form-label text-md-right">Merk</label>

                        <div class="col-md-7">
                            <select name="brand_id" id="brand_id" class="form-control select2">
                                <option value="" selected></option>
                                {% for brand in brands %}
                                <option value="{{brand.id}}">{{brand.name}}</option>
                                {% endfor %}
                            </select>
                            <span class="text-danger">
                                <small id="brand_id-error"></small>
                            </span>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="name" class="col-md-3 col-form-label text-md-right">Nama</label>

                        <div class="col-md-7">
                            <input id="name" type="text" class="form-control" name="name" autofocus>
                            <span class="text-danger">
                                <small id="name-error"></small>
                            </span>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="type" class="col-md-3 col-form-label text-md-right">Varian</label>

                        <div class="col-md-7">
                            <input id="type" type="text" class="form-control" name="type" >
                            <span class="text-danger">
                                <small id="type-error"></small>
                            </span>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="volume" class="col-md-3 col-form-label text-md-right">Volume (ml)</label>

                        <div class="col-md-7">
                            <input id="volume" type="text" class="form-control" name="volume" >
                            <span class="text-danger">
                                <small id="volume-error"></small>
                            </span>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="stock" class="col-md-3 col-form-label text-md-right">Stok</label>

                        <div class="col-md-7">
                            <input id="stock" type="text" class="form-control" name="stock" >
                            <span class="text-danger">
                                <small id="stock-error"></small>
                            </span>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="min_stock" class="col-md-3 col-form-label text-md-right">Stok Minimal</label>

                        <div class="col-md-7">
                            <input id="min_stock" type="text" class="form-control" name="min_stock" >
                            <span class="text-danger">
                                <small id="min_stock-error"></small>
                            </span>
                        </div>
                    </div>
                    
                    <div class="form-group row">
                        <label for="last_purchase_price" class="col-md-3 col-form-label text-md-right">Harga Beli</label>

                        <div class="col-md-7">
                            <input id="last_purchase_price" type="text" class="form-control" name="last_purchase_price" >
                            <span class="text-danger">
                                <small id="last_purchase_price-error"></small>
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