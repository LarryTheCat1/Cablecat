<div class='row'>
    <form name='newCable' method='post' class='form form-horizontal'>
        <input type='hidden' name='index' value='$index'>
        <div class='panel panel-primary panel-form'>
            <div class='panel-heading'>$_ADD $_CABLE $_TYPE</div>
            <div class='panel-body'>
                <div class='form-group'>
                    <label class='control-label col-md-3'>$_NAME</label>

                    <div class='col-md-9'>
                        <input type='text' class='form-control' name='NAME'/>
                    </div>
                </div>
                <div class='form-group'>
                    <label class='control-label col-md-5'>$_MODULES_COUNT</label>

                    <div class='col-md-7'>
                        <input type='number' value='4' class='form-control' name='MODULES_COUNT'/>
                    </div>
                </div>
                <div class='form-group'>
                    <label class='control-label col-md-5'>$_FIBERS_COUNT</label>

                    <div class='col-md-7'>
                        <input type='number' value='12' class='form-control' name='FIBERS_COUNT'/>
                    </div>
                </div>
                <div class='form-group'>
                    <label class='control-label col-md-5'>$_COLOR_SCHEME</label>

                    <div class='col-md-7'>
                        %COLOR_SCHEME%
                    </div>
                </div>

            </div>
            <div class='panel-footer text-center'>
                <button class='btn btn-default btn-sm'>$_CANCEL</button>
                <button class='btn btn-primary' type='submit'>$_ADD</button>
            </div>
        </div>
    </form>
</div>
