<?php
namespace Home\Controller;
use Think\Controller;
class CommonController extends Controller {
	/**
	 * [_initialize 初始化函数]
	 * @return [type] [description]
	 */
	public function _initialize () {

	}

	public function _empty() {
        header("HTTP/1.0 404 Not Found");
        $this->display('Public:404');
    }

 /**
   * [resultMsg 公共信息返回]
   * @param  [type] $status [返回状态,success或error]
   * @param  [type] $msg    [返回消息]
   * @param  string $data   [返回值]
   * @return [type]         [json]
   */
    public function resultMsg($status, $msg, $data = '') {
        $array['status'] = $status;
        $array['message'] = $msg;
        $array['data'] = $data;
        $this->ajaxReturn($array, 'json');
    }


}