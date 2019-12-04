<div class="modal fade" id="flow-form">
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
                    <input type="hidden" id="goods_id" name="goods_id">
                    <div id="info">
                        <div class="form-group row">
                            <label for="name_info" class="col-md-4 text-md-right">Nama</label>
    
                            <div class="col-md-7">
                                <div id="name_info"></div>
                            </div>
                        </div>
    
                        <div class="form-group row">
                            <label for="stock_info" class="col-md-4 text-md-right">Stok</label>
    
                            <div class="col-md-7">
                                <div id="stock_info"></div>
                            </div>
                        </div>
    
                        <div class="form-group row">
                            <label for="purchase_info" class="col-md-4 text-md-right">Harga Beli Terakhir</label>
    
                            <div class="col-md-7">
                                <div id="purchase_info"></div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="quantity" class="col-md-4 text-md-right">Jumlah</label>

                        <div class="col-md-7">
                            <input id="quantity" type="text" class="form-control" name="quantity">
                            <span class="text-danger">
                                <small id="quantity-error"></small>
                            </span>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="detail" class="col-md-4 text-md-right">Keterangan</label>

                        <div class="col-md-7">
                            <input id="detail" type="text" class="form-control" name="detail">
                            <span class="text-danger">
                                <small id="detail-error"></small>
                            </span>
                        </div>
                    </div>

                    <div class="form-group row purchase-form">
                        <label for="purchase_price" class="col-md-4 text-md-right">Harga Beli</label>

                        <div class="col-md-7">
                            <input id="purchase_price" type="text" class="form-control" name="purchase_price">
                            <span class="text-danger">
                                <small id="purchase_price-error"></small>
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
                        <button type="button" class="btn btn-primary" id="flow-submit">
                            Submit
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>