<?php
namespace app\api\controller;
use think\Controller;
use think\Db;
class Create extends Controller
{
	public function index(){
		$CreatStudent = new \app\common\librarie\CreateStudent();

		$studentList = $CreatStudent->create(500);

		dump($studentList);
	}
	public function insert_student(){
		if(isset($_GET['count'])){
			$n = $_GET['count'];
		}else{
			$n = 5000;
		}
		if(isset($_GET['Isappend'])){
			$Isappend = $_GET['Isappend'];
		}else{
			$Isappend = false;
		}
		if(!$Isappend){
			// $model = new \think\Model;
			Db::query('TRUNCATE table `student`');
		}
		
		$CreatStudent = new \app\common\librarie\CreateStudent();

		$studentList = $CreatStudent->create($n);

		for($i=0;$i<$n;$i++){
			$hobby = '';
			foreach ($studentList[$i]['hobby'] as $key => $value) {
                if($hobby == ''){
                    $hobby = $value;
                }else{
                    $hobby .= '_'.$value;
                }
            }
            $hobby2 = '';
			foreach ($studentList[$i]['hobby2'] as $key => $value) {
                if($hobby2 == ''){
                    $hobby2 = $value;
                }else{
                    $hobby2 .= '_'.$value;
                }
            }
            $studentList[$i]['hobby'] = $hobby;
            $studentList[$i]['hobby2'] = $hobby2;

        	$studentList[$i]['watmosphere'] = $studentList[$i]['weight'][0];
        	$studentList[$i]['whygiene'] = $studentList[$i]['weight'][1];
        	$studentList[$i]['wvice'] = $studentList[$i]['weight'][2];
        	$studentList[$i]['wWaR'] = $studentList[$i]['weight'][3];
        	$studentList[$i]['welectric_contest'] = $studentList[$i]['weight'][4];
        	$studentList[$i]['whobby'] = $studentList[$i]['weight'][5];
        	$studentList[$i]['wexpenses'] = $studentList[$i]['weight'][6];
        	$studentList[$i]['wfrom'] = $studentList[$i]['weight'][7];
        
            unset($studentList[$i]['weight']);
            $studentList[$i]['input_time'] = time();
            $studentList[$i]['state'] = 1;
		}
        Db::query('TRUNCATE table `dorm`');
		$result = db('student')->insertAll($studentList);
		if($result){
    		$return['code'] = 0;
    	}else{
    		$return['code'] = 1;
    	}
    	$return = json_encode($return,JSON_UNESCAPED_UNICODE); 
    	return $return;
		
	}


	public function createdorm($n){
		$dorms = [];
		for($i = 1;$i<$n+1;$i++){
			$num = (str_pad($i,4,"0",STR_PAD_LEFT));
			$num = 'd'.$num;
			$dorms[] = $num;
		}
		return $dorms;
	}

	public function creatStudents($m){
		$CreatStudent = new \app\common\librarie\CreateStudent();

		$studentList = $CreatStudent->create($m);

		for($i=0;$i<$m;$i++){
			$hobby = '';
			foreach ($studentList[$i]['hobby'] as $key => $value) {
                if($hobby == ''){
                    $hobby = $value;
                }else{
                    $hobby .= '_'.$value;
                }
            }
            $hobby2 = '';
			foreach ($studentList[$i]['hobby2'] as $key => $value) {
                if($hobby2 == ''){
                    $hobby2 = $value;
                }else{
                    $hobby2 .= '_'.$value;
                }
            }
            $studentList[$i]['hobby'] = $hobby;
            $studentList[$i]['hobby2'] = $hobby2;

        	$studentList[$i]['watmosphere'] = $studentList[$i]['weight'][0];
        	$studentList[$i]['whygiene'] = $studentList[$i]['weight'][1];
        	$studentList[$i]['wvice'] = $studentList[$i]['weight'][2];
        	$studentList[$i]['wWaR'] = $studentList[$i]['weight'][3];
        	$studentList[$i]['welectric_contest'] = $studentList[$i]['weight'][4];
        	$studentList[$i]['whobby'] = $studentList[$i]['weight'][5];
        	$studentList[$i]['wexpenses'] = $studentList[$i]['weight'][6];
        	$studentList[$i]['wfrom'] = $studentList[$i]['weight'][7];
        
            unset($studentList[$i]['weight']);
            $studentList[$i]['input_time'] = time();
		}

		return $studentList;
	}
	
}