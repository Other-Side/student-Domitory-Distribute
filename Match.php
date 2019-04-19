<?php

namespace app\api\controller;
use app\common\librarie;
use app\common\model;
class Match
{
	private $student_list = array();

	public function __construct(){
		$studentModel = new \app\common\model\Student();
		$student_list = $studentModel->getAll();
		foreach ($student_list as $key => $value) {
			$this->student_list[$value['number']] = $value;
		}
	}



	//两个学生匹配度
    public function BothMatch()
    {
    	$return = [];
    	if(!isset($_POST['num'])){
    		$return['code'] = 1;
    		$return['msg'] = '没有输入学号';
    	}else{
    		if(count($_POST['num'])<2){
    			$return['code'] = 1;
    			$return['msg'] = '学号个数少于两个';
    		}else{
    			$nums = $_POST['num'];
		    	// $nums = ['2019150027','2019150210'];
		    	$numA = $nums[0];
		    	$numB = $nums[1];
		    	$studentModel = new \app\common\model\Student();
		    	$stuA = $studentModel->getByNumber($numA);
		    	$stuB = $studentModel->getByNumber($numB);
		    	// dump($stuA);die;
	    		if(!$stuA || !$stuB){
	    			// dump(1);die;
	    			$return['code'] = 1;
    				$return['msg'] = '输入的学号有误';
	    		}else{
	    			$matchModel = new \app\common\librarie\MathModel();
    				$matchdegree = $matchModel->bothMR($stuA,$stuB);
    				$return['code'] = 0;
    				$return['msg'] = '成功';
    				$return['data'] = $matchdegree;

	    		}
    		}
    		
    	}
    	
    	$return = json_encode($return,JSON_UNESCAPED_UNICODE); 
    	
        return $return;
    }



    //获取学生数据
    public function getStudents(){
    	if(isset($_GET['show'])){
    		$show = $_GET['show'];
    	}else{
    		$show = false;
    	}
    	if($show == true){
    		$studentModel = new \app\common\model\Student();
    		$val = $studentModel->getvalue();
    		foreach ($this->student_list as $key => $value) {
    			$item['id'] = $value['id'];
    			$item['姓名'] = $value['name'];
    			$item['学号'] = $value['number'];
    			$item['性别'] = $value['sex'];
    			$item['班级'] = $value['class'];

    			$item['宿舍氛围'] = $val['atmosphere'][$value['atmosphere']];
    			$item['宿舍卫生'] = $val['hygiene'][$value['hygiene']];
    			$item['睡觉恶习'] = $val['vice'][$value['vice']];
    			$item['作息'] = $val['WaR'][$value['WaR']];
    			$item['电竞'] = $val['electric_contest'][$value['electric_contest']];
    			$hobby = [];
    			$hobbylist = explode('_',$value['hobby']);
    			foreach ($hobbylist as $key => $v) {
    				$hobby[] = $val['hobby'][$v];

    			}
    			$hobby = implode($hobby,'、');
    			$item['爱好'] = $hobby;
    			$item['生源地'] = $val['from'][$value['from']];
				$item['花销'] = $val['expenses'][$value['expenses']];

				$hobby = [];
    			$hobbylist = explode('_',$value['hobby2']);
    			foreach ($hobbylist as $key => $v) {
    				$hobby[] = $val['hobby'][$v];

    			}
    			$hobby = implode($hobby,'、');
    			$item['宿友爱好需求'] = $hobby;
    			$item['宿友生源地需求'] = $val['from'][$value['from2']];
    			$item['宿友花销需求'] = $val['expenses'][$value['expenses2']];

    			$item['宿舍氛围权重'] = $value['watmosphere'];
    			$item['宿舍卫生权重'] = $value['whygiene'];
    			$item['睡觉恶习权重'] = $value['wvice'];
    			$item['作息权重'] = $value['wWaR'];
    			$item['电竞权重'] = $value['welectric_contest'];
    			$item['爱好权重'] = $value['whygiene'];
    			$item['生源地权重'] = $value['wfrom'];
    			$item['花销权重'] = $value['wexpenses'];

    			$data[] = $item;
    			$return['code'] = 0;
    			$return['data'] = $data;
    		}
    	}else if($show == false){
    		$data = $this->student_list;
    		$return['code'] = 0;
    		$return['data'] = $data;
    	}else{
    		$return['code'] = 1;
    		$return['msg'] = '参数出错';
    	}

    	$return = json_encode($return,JSON_UNESCAPED_UNICODE);
    	return $return;
    }


    public function greedy(){
    	
    	$n = 4;//宿舍成员数量
    	$m = sizeof($this->student_list);//学生数量
    	$numOfDorm =0;//宿舍数量
    	if ($m%$n==0) {
    		$numOfDorm = (int)($m/$n);
    	}else
    	{
    		$numOfDorm = (int)($m/$n)+1;
    	}

    	$dorm = new \app\api\controller\Create();	
    	$dormList = $dorm->createdorm($numOfDorm);
    	// dump($dormList);
    	$stus = $this->student_list;
    	$dormMap = [];
    	foreach ($dormList as $key => $value) {
    		if(count($stus) == 0){
    			break;
    		}
    		foreach ($stus as $k => $val) {
    			$dormMap[$value][] = $val;
    			unset($stus[$k]);
    			break;
    		}
    		$MR = 0;
    		//找到学生$student最合适的n-1个舍友
    		for ($i=0; $i < $n-1; $i++) {
    			//寻找宿舍$value第i+2个室友
    			$maxMatch = 0;
    			$maxNum = 0;
    			$afterUStudents = "";
    			if(count($stus) == 0){
	    			break;
	    		}
    			foreach ($stus as $k => $val) {
    				//将要计算匹配度的学生放在一个数组中
    				$afterUStudents = $dormMap[$value];
    				$afterUStudents[] = $val;
    				//计算该数组内学生的匹配度
    				$MathModel = new \app\common\librarie\MathModel();
	    			$result = $MathModel->dormMR($afterUStudents);	
	    			if ($result>$maxMatch) {
	    			 	$maxNum = $k;
	    			 	$maxMatch = $result;
	    			}
    			 }
    			 //最好的匹配对象学号在$maxNum中
    			 //扔进该宿舍集合，并从原待分配中数组移出
    			$dormMap[$value][] = $stus[$maxNum];
    			// $dormMap[$value]['MR'] = $maxMatch;
    			unset($stus[$maxNum]);
    			if($i == 2){
    				$MR = $maxMatch;
    			}

    		}
			$dormMap[$value]['MR'] = $MR;
    		//dump($stus);die;
    		
    	}

    	dump($dormMap);
    }

}
