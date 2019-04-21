<?php

namespace app\api\controller;
use app\common\librarie;
use app\common\model;
use think\Db;

class Simulate
{

	public function __construct(){
		// $studentModel = new \app\common\model\Student();
		// $student_list = $studentModel->getAll();
		// foreach ($student_list as $key => $value) {
		// 	$this->student_list[$value['number']] = $value;
		// }
	}
	public function compares(){
		// 
		 //$arithmetic = 1;
		// $this->compare($arithmetic,200,4);
		// foreach ($arr as $key => $value) {
		// 	$this->compare($arithmetic,$value,4);
		// }
		for ($i=0; $i <30; $i++) { 
			# code...
			$this->compare(2,500,4);
		}
		for ($i=0; $i <30; $i++) { 
			# code...
			$this->compare(3,500,4);
		}
		for ($i=0; $i <30; $i++) { 
			# code...
			$this->compare(5,500,4);
		}
		

		// for ($i=0; $i < 30; $i++) { 
		// 	$this->compare(6,500,4);
		// }
		// $arr = [50,100,200,500,1000];
		// $arithmetic = 6;
		// foreach ($arr as $key => $value) {
		// 	$this->compare($arithmetic,$value,4);
		// 	# code...
		// }
		// foreach ($arr as $key => $value) {
		// 	$this->compare($arithmetic,$value,4);
		// 	# code...
		// }
		// foreach ($arr as $key => $value) {
		// 	$this->compare($arithmetic,$value,4);
		// 	# code...
		// }
		// foreach ($arr as $key => $value) {
		// 	$this->compare($arithmetic,$value,4);
		// 	# code...
		// }
		// for ($i=0; $i < 30; $i++) { 
		// 	$this->compare(3,500,4);
		// 	# code...
		// }
		// for ($i=0; $i < 5; $i++) { 
		// 	$this->compare(1,5000,4);
		// 	# code...
		// }
		// for ($i=0; $i < 5; $i++) { 
		// 	$this->compare(2,5000,4);
		// 	# code...
		// }
		// for ($i=0; $i < 5; $i++) { 
		// 	$this->compare(3,5000,4);
		// 	# code...
		// }
		// for ($i=0; $i < 5; $i++) { 
		// 	$this->compare(5,2000,4);
		// 	# code...
		// }
		// for ($i=0; $i < 5; $i++) { 
		// 	$this->compare(6,5000,4);
		// 	# code...
		// }

		//30 1 * * * php /usr/share/nginx/html/sbook/dorm1/dorm/public/index.php api/Simulate/compares
		//30 1 * * * 
		//knn20000 2个
		//nknn5000 1个
		//nknn10000 2个
		//nknn20000 3个
		//  $arithmetic = 3;
		// for ($i=0; $i < 1; $i++) { 
		// 	$this->compare($arithmetic,5000,4);
		// }

		// $arithmetic = 3;
		// for ($i=0; $i < 2; $i++) { 
		// 	$this->compare($arithmetic,10000,4);
		// }
		// $arithmetic = 3;
		// for ($i=0; $i < 3; $i++) { 
		// 	$this->compare($arithmetic,20000,4);
		// }
		// $arithmetic = 2;
		// for ($i=0; $i < 2; $i++) { 
		// 	$this->compare($arithmetic,20000,4);
		// }

		// $arithmetic = 6;
		// //5000->68秒
		// //1000000=3.8小时
		// //2000000=7.5个小时
		// $this->compare($arithmetic,500,4);

	} 
	//贪心和普通的比较
	public function compare($arithmetic,$m,$n){
    	$numOfDorm = ceil($m/$n);//宿舍数量
    	
    	$dorm = new \app\api\controller\Create();	
    	$dormList = $dorm->createdorm($numOfDorm);
    	$student_list = $dorm->creatStudents($m);

    	$Arithmetic = new \app\common\librarie\Arithmetic($student_list,$dormList,$n);

    	switch ($arithmetic)
		{
		case 1:
			$arithmeticR = $Arithmetic->greedy();
			$record1['arithmetic'] = '贪心算法';
			break;  
	  	case 2:
			$arithmeticR = $Arithmetic->KNN();
			$record1['arithmetic'] = 'KNN算法';
			break;
		case 3:
			$arithmeticR = $Arithmetic->NKNN();
			$record1['arithmetic'] = '改进KNN算法';
			break;
		case 5:
			$arithmeticR = $Arithmetic->graph();
			$record1['arithmetic'] = '图论';
			break;
		case 6: 
			$arithmeticR = $Arithmetic->ant();
			$record1['arithmetic'] = '蚁群聚类';
			break;
		case 7: 
			$arithmeticR = $Arithmetic->kmeans();
			$record1['arithmetic'] = 'kmeans';
			break;
		default:
		  $return['code'] = 1;
		  $return['msg'] = '输入算法号码错误';
		}


    	if(isset($arithmeticR)){
			$ordinary = $Arithmetic->ordinary();
	    	$record2 = [
	    		'size' => $m
	    		,'LMRN' => $arithmeticR['LMRN']
	    		,'average' => $arithmeticR['AaS']['average']
	    		,'standard' => $arithmeticR['AaS']['standard']
	    		,'runtime' => $arithmeticR['runTime']
	    		,'oAverage' => $ordinary['AaS']['average']
	    		,'oStandard' => $ordinary['AaS']['standard']
	    		,'oRuntime' => $ordinary['runTime']
	    		,'oLMRN' => $ordinary['LMRN']
	    		,'inputTime' => date('Y-m-d h:i:s',time())
	    	];

	    	$record = array_merge($record1,$record2);
	    	$result = Db::table('record')->insert($record);
	    	// dump($record);die;
	    	if($result){
	    		$return['code'] = 0;
	    		$return['data'] = $arithmeticR;
	    	}else{
	    		$return['code'] = 1;
	    	}
    	}

    	$return = json_encode($return,JSON_UNESCAPED_UNICODE); 
    	return $return;
    }

    //计算平均值和标准差
    public function AveAndSta($list){
    	$n = count($list);
    	$average = 0;
    	$standard = 0;
    	for($i = 0 ; $i < $n ; $i++){
    		$average += $list[$i];
    	}
    	$average = $average/$n;
    	for($i = 0 ; $i < $n ; $i++){
    		$standard += pow(($list[$i]-$average),2);
    	}
    	$standard = sqrt($standard/$n);
    	$data = ['average' => $average,'standard'=>$standard];

    	return $data;
    }

 

    
}