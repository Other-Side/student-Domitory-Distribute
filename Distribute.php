<?php

namespace app\api\controller;
use app\common\librarie;
use app\common\model;
use think\Db;
class Distribute
{
	private $student_list = array();
	private $dormList = array();
	private $n = 4;

	public function __construct(){
		$this->student_list = Db::table('student')->select();
		$numOfDorm = ceil(count($this->student_list)/$this->n);//宿舍数量
		$dorm = new \app\api\controller\Create();	
    	$this->dormList = $dorm->createdorm($numOfDorm);
	}

	public function distribute(){
		if(isset($_GET['arithmetic'])){
			$arithmetic = $_GET['arithmetic'];
			
			$Arithmetic = new \app\common\librarie\Arithmetic($this->student_list,$this->dormList,$this->n);
			switch ($arithmetic)
			{
			case 0:
				$arithmeticR = $Arithmetic->ordinary();
				break; 
			case 1:
				$arithmeticR = $Arithmetic->greedy();
				break; 
		  	case 2:
				$arithmeticR = $Arithmetic->KNN();
				break; 
		  	case 3:
				$arithmeticR = $Arithmetic->NKNN();
				break;  
			case 5:
			  $arithmeticR = $Arithmetic->graph();
			  
			  break;
			default:
			  $return['code'] = 1;
			  $return['msg'] = '输入算法号码错误';
			}

			if(isset($arithmeticR)){
				$result = $this->insert_dorm($arithmeticR);
				if($result){
					$return['code'] = 0;
					$return['msg'] = '分配成功';
				}else{
					$return['code'] = 1;
					$return['msg'] = 'sql错误';
				}
			}
		}else{
			$return['code'] = 1;
			$return['msg'] = '请输入算法号码';
		}
    	$return = json_encode($return,JSON_UNESCAPED_UNICODE); 
    	return $return;
	}

	public function insert_dorm($data){
		// dump($data);die;
		$data = $data['data'];
		$list = [];
		foreach ($data as $key => $value) {
			$item['dormNum'] = $key;
			$item['MR'] = $value['MR'];
			$stus = [];
			
			for ($i=0; $i < count($value['stus']); $i++) { 
				# code...
				$stus[] = $value['stus'][$i];
			}

			if(count($stus) == 1){
				$item['stus'] = $stus[0];
			}else{
				$item['stus'] = implode('、',$stus);
			}
			// dump($item);die;
			
			
			$list[] = $item;
		}
		Db::query('TRUNCATE table `dorm`');
		$result = Db::table('dorm')->insertAll($list);
		return $result;
	}


}