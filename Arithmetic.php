<?php
namespace app\common\librarie;

class Arithmetic
{
	private $student_list = array();
	private $dormList = array();
	private $n = 0;
	private $table = 0; 

	public function __construct($student_list,$dormList,$n){
		$this->student_list = $student_list;
		$this->dormList = $dormList;
		$this->n = $n;
				//相异度矩阵
	}


	public function createtable($stus)
	{
		
		$table[] = [];
		$MathModel = new \app\common\librarie\MathModel();
		for ($i=0; $i < count($stus); $i++) { 
			$item = [];
			for ($j=0; $j < count($stus); $j++) {
				$item[] = (float)$MathModel->bothMR($stus[$i],$stus[$j]);	
			}
			$table[$i] = $item;
		}
		$this->table = $table;
		//var_dump($this->table);
	}	
	
		

	public function dis($stua,$stub)
	{
		//"学生stus[$stua]，stus[$stub]之间的距离"
		// echo $stua;
		// echo $stub;
		// echo "\n";
		if ($stua == $stub) {
			return 100;
			# code...
		}
		return  $this->table[$stua][$stub];
		

	}

	public function randcent($stus,$k)
	{
		//"随机从stus中生成k个心"
		$cents = [];
		for ($i=0; $i < $k; $i++) { 
			$centkey = array_rand($stus,1);
			if (in_array($centkey,$cents)) {
				$i--;
			}else
			{
				$cents[] = $centkey;				
			}
			
			//var_dump($cents);
		}
		return $cents;

	}


	public function minCent($stu,$centMap)
	{
		//"计算centMap中哪个中心与stu最近"
		//stu为stus[$stu]
		$maxMR = 0;
		$mincent = 0;
		
		foreach ($centMap as $key => $value) {
			$dis = $this->dis($key,$stu);
			// echo "</br>";
			// echo $key."  ";
			// echo $stu."  ";
			// echo $dis."  ";
			//  echo "</br>";
			
			if ($dis > $maxMR) {
				$maxMR = $dis;
				// echo "MR".$maxMR;
				$mincent = $key;
			}
		}
		return $mincent;

	}

	public function centStu($stus)
	{
		//"计算stus中哪个学生为中心点"
		$maxMR  = 0;
		$centStu = 0;
	
		foreach ($stus as $key => $value) {
			$countDis = 0;
			foreach ($stus as $key2 => $value2) {
				$countDis += $this->dis($value2,$value);
			}

			if ($countDis > $maxMR) {
				$maxMR = $countDis;
				$centStu = $value;
			}
		}
		
		return $centStu;

	}



	public function kmeans(){
		$timeStart = $this->getMicrotime();
		$MathModel = new \app\common\librarie\MathModel();
		$this->createtable($this->student_list);

		//var_dump($this->table);
		//$timeStart = $this->getMicrotime();
		echo "start".$timeStart;
		$stus = $this->student_list;
		$dormList = $this->dormList;
		$n = $this->n;
		$k = count($this->dormList);
		$isChange = TRUE;
		$sampleCount = count($stus);
		$centList  = $this->randcent($stus,$k);
		$centMap = [];
		
		//var_dump($centList);
		//echo "</br>";
		//var_dump($this->table);
		//echo "</br>";
		//第一次分配
		foreach ($centList as $key => $value) {
			$centMap[$value]=[$value];
		}
		foreach ($stus as $key => $value){
			if (isset($centMap[$key])) {
				# code...
			}else
			{
				$mincent = $this->minCent($key,$centMap);
				$centMap[$mincent][] = $key;
			}
			
		}
		// echo "</br>";
		// var_dump($centMap);
		// echo "</br>";
		//更新中心点
		foreach ($centMap as $centStu => $stus) {
			$newcentstu = $this->centStu($stus);

			// echo "</br>";
			// echo "sss";
			// var_dump($newcentstu);
			// echo "</br>";

			if ($newcentstu != $centStu) {
				//array_splice($centMap,$centStu,1);
				unset($centMap[$centStu]);
				// var_dump($centMap);
				// echo "</br>";
				$centMap[$newcentstu] = $stus;
				// //array_splice($centMap,$centStu,1);
				// var_dump($centMap);
				// echo "</br>";
			}
		}

		//var_dump($centMap);
		//die;

		//迭代分配
		$times = 0;
		while($isChange)
		{
			$isChange = FALSE;
			$times++;
			if ($times>10) {
				break;
			}
			//重新归类
			foreach ($centMap as $centStu => $stus) {
				foreach ($stus as $key => $stu) {
					$newcent = $this->minCent($stu,$centMap);
					if ($newcent != $centStu) {
						$isChange = TRUE;
						// echo "</br>";
						// echo "stu".$stu;
						// var_dump($centMap);
						// echo "newcent".$newcent;
						// echo "</br>";
						// echo "centStu".$centStu;
						unset($centMap[$centStu][$key]);

						// echo "</br>";
						// var_dump($centMap);
						// echo 1;
						// echo "</br>";
						$centMap[$newcent][] = $stu;
					}
				}
			}

			foreach ($centMap as $centStu => $stus) {
				$newcentstu = $this->centStu($stus);

				// echo "</br>";
				// echo "sss";
				// var_dump($newcentstu);
				// echo "</br>";

				if ($newcentstu != $centStu) {
					//array_splice($centMap,$centStu,1);
					unset($centMap[$centStu]);
					// var_dump($centMap);
					// echo "</br>";
					$centMap[$newcentstu] = $stus;
					// //array_splice($centMap,$centStu,1);
					// var_dump($centMap);
					// echo "</br>";
				}
			}

		}
		$c = 0;
		foreach ($centMap as $key => $value) {
			
			if (count($value)>=($this->n)) {
				//var_dump($value);
				//echo "string";
				$c ++;
			}
		}

		//var_dump($centMap);
		//echo $c;


		//迭代结束。
		//对类内元素数量大于n的类直接分宿舍
		//对类内元素数量小于n的类和剩下的用贪心
		$tempDormMap =[];
		$dormMap = [];
		$dormList = $this->dormList;
		$beenDistrubuteStus = [];
		$waitDistrubuteStus = [];
		$n = $this->n;
		$dormNum = 0;
		foreach ($centMap as $key => $value) {
			
			$stus = $value;
			unset($centMap[$key]);
			$num = count($stus);

			$stus = array_values($stus);

			while ($num>=$n) {
				for ($i=0; $i < $n; $i++) { 
					$tempDormMap[$dormNum][]=$stus[$i];
					$beenDistrubuteStus[] = $stus[$i];
					unset($stus[$i]);
				}
				$num = count($stus);
				$stus = array_values($stus);
				$dormNum++;
			}

			for ($i=0; $i < count($stus); $i++) { 
				$waitDistrubuteStus[] = $stus[$i];
			}
		}

		// echo " ".$dormNum;
		 // var_dump($tempDormMap);
		 // echo "</br>";
		// var_dump($beenDistrubuteStus);
		// echo "</br>";
		// var_dump($waitDistrubuteStus);
		$waitdormList = [];
		foreach ($dormList as $key => $value) {
			if (count($tempDormMap)>0) {
				for ($i=0; $i < $n; $i++) {
					$dormMap[$value]['stus'][]= $this->student_list[$tempDormMap[0][$i]];
					# code...
				}
				$dormMap[$value]['MR'] = $MathModel->dormMR($dormMap[$value]['stus']);
				unset($tempDormMap[0]);
				$tempDormMap = array_values($tempDormMap);
			}
			else
			{
				$waitdormList[] = $value;
			}
		}
		//echo count($dormMap);
		// var_dump($dormMap);
		//  echo "</br>";


		foreach ($dormMap as $key1 => $value1) {
    		$item = [];
    		foreach ($value1['stus'] as $key2 => $value2) {
    			$item[] = $value2['number'];
    		}
    		
    		$dormMap[$key1]['stus'] = $item;
    	}
    	
    	


		//剩下的$waitDistrubuteStus贪心
		$waitstus = [];
		foreach ($waitDistrubuteStus as $key => $value) {
			$waitstus[] =  $this->student_list[$value];
		}

		//echo count($waitstus);
		$greedyResult = $this->greedyByargu($waitstus,$waitdormList);


		//var_dump($greedyResult);
		//echo "</br>";echo "</br>";
		$dormMap = array_merge($dormMap,$greedyResult["data"]);
		//var_dump($dormMap);
		//echo "</br>";

		$MRList = [];
		foreach ($dormMap as $key1 => $value1) {
    		$MRList[] = $value1['MR'];
    	}

		$AaS = $this->AveAndSta($MRList);
		$timeEnd = $this->getMicrotime();
		$runTime = $timeEnd - $timeStart;
		$LMRN = $this->countLMRN($MRList,$AaS['average']);
		$return['LMRN'] = $LMRN;
		$return['data'] = $dormMap;
    	$return['AaS'] = $AaS;
    	$return['runTime'] = $runTime;

    	echo " end ".$timeEnd." ";
    	echo "time ".$runTime;
    	echo "</br>";

    	return $return;


	}



	
		
	//蚁群聚类算法
	public function ant(){
		$NumReflash = 200000;
		$timeStart = $this->getMicrotime();
		$stus = $this->student_list;
		$dormList = $this->dormList;
		$n = $this->n;
		$MathModel = new \app\common\librarie\MathModel();
		
		$dormMap = [];
		$MRList = [];
		//dormlist（i,宿舍号）
		//dormmap(宿舍号，学号，i：学生)
		//dormmap(宿舍号，mR：匹配度)
		//随机将所有学生安排进宿舍
		foreach ($dormList as $key => $value) {
    		if(count($stus) == 0){
				break;
			}
    		$MR = 0;
    		//为$value宿舍安排学生
    		for ($i=0; $i < $n; $i++) {
    			if(count($stus) == 0){
    				$MR = $MathModel->dormMR($dormMap[$value]['stus']);
	    			break;
	    		}
	    		$stu = $this->random($stus);
	    		$dormMap[$value]['stus'][] = $stu['value'];
				array_splice($stus,$stu['key'],1);
	    		//unset($stus[$k]);
				if($i == $n-1){
					$MR = $MathModel->dormMR($dormMap[$value]['stus']);	
				}
    		}
    		
    		$dormMap[$value]['MR'] = $MR;
		}
		// foreach ($dormMap as $key => $valuee) {
		// 	foreach ($valuee['stus'] as $key => $valuee) {
		// 		echo $valuee['name'];
		// 	}
		// 	echo "\n";
		// }


		//蚁群聚类
		$dormsize = count($dormList);
		

		for ($i=0; $i < $NumReflash; $i++) { 
			$dorm1 = [];//被选中的宿舍
			$dorm2 = [];//被选中的宿舍
			$stu1 = [];//被选中交换的学生
			$stu2 = [];//被选中交换的学生
			//随机获取2个宿舍
			$dormNum1 = array_rand($dormMap,1);
			$dorm1 = $dormMap[$dormNum1];
			$dormNum2 = array_rand($dormMap,1);
			$dorm2 = $dormMap[$dormNum2];
			$nstu1 = array_rand($dorm1['stus']);
			$nstu2 = array_rand($dorm2['stus']);
			$stu1 = $dorm1['stus'][$nstu1];
			$stu2 = $dorm2['stus'][$nstu2];
			if ($dormNum1==$dormNum2) 
			{
				continue;
				# code...
			}

			 // foreach ($dorm1['stus'] as $key => $valuee) {
			 // 	echo $valuee['name'];
			 // }
			 // echo "\n";
			 // echo $stu1['name'];

			 // echo $stu2['name'];
			 // echo "\n";

			//var_dump($stu1);
			//var_dump($stu2);
			//var_dump($dorm1['stus']);
			// foreach ($ as $key => $valuee) {
			// 	var_dump($valuee);
			// }

			//尝试交换学生
			$ndorm1 = $dorm1;
			//unset($ndorm1['stus'][$nstu1]);
			//var_dump($ndorm1['stus']);
			array_splice($ndorm1['stus'],(int)$nstu1,1);
			$ndorm1['stus'][]=$stu2;
			//var_dump($ndorm1['stus']);
			// foreach ($ndorm1['stus'] as $key => $valuee) {
			// 	echo $valuee['name'];
			// }
			$ndorm2 = $dorm2;
			array_splice($ndorm2['stus'],(int)$nstu2,1);
			$ndorm2['stus'][] = $stu1;
			//计算交换后匹配度
			//
			//echo "a\n";
			// var_dump($ndorm1['stus']);
			// var_dump($dormMap[$dormNum1]['stus']);
			// echo count($ndorm1['stus']);
			$afterUStudents = $ndorm1['stus'];


			$resultn1 = $MathModel->dormMR($ndorm1['stus']);
	    	//$resultn1 = $MathModel->dormMR($dormMap[$dormNum1]['stus']);
	    	$resultn2 = $MathModel->dormMR($ndorm2['stus']);


	    	//echo $resultn1."A".$dorm1['MR']."b".$resultn2."c".$dorm2['MR'];
	    	// if ($resultn1>=$dorm1['MR']&&$resultn2>=$dorm2['MR']) {
	    	if ($resultn1+$resultn2>$dorm1['MR']+$dorm2['MR']) {
	    		//交换
	    		array_splice($dormMap[$dormNum1],(int)$nstu1,1);
	    		$dormMap[$dormNum1]['stus'][] = $stu2;
	    		$dormMap[$dormNum1]['MR'] = $resultn1;
	    		array_splice($dormMap[$dormNum2],(int)$nstu2,1);
	    		$dormMap[$dormNum2]['stus'][] = $stu1;
	    		$dormMap[$dormNum2]['MR'] = $resultn2;
	    	}
    		$dormMap[$value]['MR'] = $MR;
		}
		foreach ($dormMap as $key => $value) {
			$MRList[] = $dormMap[$key]['MR'];
		}
		//var_dump($MRList);


		$AaS = $this->AveAndSta($MRList);
    	$timeEnd = $this->getMicrotime();
    	$runTime = $timeEnd - $timeStart;

    	$LMRN = $this->countLMRN($MRList,$AaS['average']);
    	$return['LMRN'] = $LMRN;

    	$return['data'] = $dormMap;
    	$return['AaS'] = $AaS;
    	$return['runTime'] = $runTime;


    	return $return;
		
	}

	//图论算法
	public function graph(){
		$timeStart = $this->getMicrotime();
		$stus = $this->student_list;
		$dormList = $this->dormList;
		$n = $this->n;
		$MathModel = new \app\common\librarie\MathModel();
		

		//相异度矩阵
		$table = [];
		for ($i=0; $i < count($stus)-1; $i++) { 
			$item = [];
			for ($j=$i+1; $j < count($stus); $j++) {

				$item[$stus[$j]['number']] = (float)$MathModel->bothMR($stus[$i],$stus[$j]);	
			}
			$table[$stus[$i]['number']] = $item;
		}
		
		$dormMap = [];
		$stuNList = [];
		foreach ($stus as $key => $value) {
			$stuNList[] = $value['number'];
		}
		foreach ($dormList as $key1 => $value1) {
			if(count($stuNList) == 0)break;
			if(count($stuNList) == 1){
				
				$dormMap[$value1]['MR'] = [0];
				// $dormMap[$value1][] = $stu
				foreach ($stuNList as $key => $value) {
					$dormMap[$value1]['stus'][] = $value;
				}
				break;
			} 
			
			//遍历找出匹配度最高学生
			$max = [];			
			foreach ($table as $key2 => $value2) {

				foreach ($value2 as $key3 => $value3) {
					$imax = [];
					if(empty($max)){
						$imax[] = $value3;
						$imax[] = $key2;
						$imax[] = $key3;
						$max = $imax;
					}else if($value3>$max[0]){
						$imax[] = $value3;
						$imax[] = $key2;
						$imax[] = $key3;
						$max = $imax;
					}
				}
			}
			$dormMap[$value1]['MR'][] = $max[0];
			$dormMap[$value1]['stus'][] = (string)$max[1];
			$dormMap[$value1]['stus'][] = (string)$max[2];
			if(count($stuNList) == 2){
				break;
			} 
		
			$stuNList = array_diff($stuNList, [$max[1], $max[2]]);
			
			//学生匹配度最小树生成
			for ($i=0; $i < $n-2; $i++) { 
				$imax = [];
				foreach ($stuNList as $key2 => $value2) {
					$iimax = [
						'MR' => [],
					];
					$iimax[] = $value2;

					//拿到遍历学生和已确定学生的匹配度
					for ($j=0; $j <$i+2 ; $j++) {
						if(isset($table[$value2][$dormMap[$value1]['stus'][$j]])){
							$iimax['MR'][] = $table[$value2][$dormMap[$value1]['stus'][$j]];
						}
						if(isset($table[$dormMap[$value1]['stus'][$j]][$value2])){
							$iimax['MR'][] = $table[$dormMap[$value1]['stus'][$j]][$value2];
						} 
					}
					
					
					//比较出最好学生
					if(empty($imax)){
						$imax = $iimax;
					}
					else{
						// // 这里是另一种
						// $a = 0;$b = 0;
						// foreach ($iimax['MR'] as $key => $value) {
						// 	$a += $value;
						// }
						// foreach ($imax['MR'] as $key => $value) {
						// 	$b += $value;
						// }
						// $imax = $a>$b?$iimax:$imax;


						$imax = $this->MRMax($imax,$iimax);

					}
					
				}
				
				foreach ($imax['MR'] as $key => $value) {
					$dormMap[$value1]['MR'][] = $value;
				}
				$dormMap[$value1]['stus'][] = $imax[0];
				$stuNList = array_diff($stuNList, [$imax[0]]);

				if(count($stuNList) == 0){
					break;
				} 
				
			}

			

			$numList = [];
			for($i = 0;$i<count($dormMap[$value1]['stus']);$i++){
				$numList[] = $dormMap[$value1]['stus'][$i];
			}
			$table = $this->remove($table,$numList);

		}
		
		$MRList = [];
		foreach ($dormMap as $key => $value) {
			$size = 0;
			$sum = 0;
			foreach ($value['MR'] as $key1 => $value1) {
				$sum += $value1;
				$size++;
			}

			$dormMap[$key]['MR'] = $sum/$size;
			$MRList[] = $sum/$size;
		}

		$AaS = $this->AveAndSta($MRList);
    	$timeEnd = $this->getMicrotime();
    	$runTime = $timeEnd - $timeStart;
   		$LMRN = $this->countLMRN($MRList,$AaS['average']);
    	$return['LMRN'] = $LMRN;

    	$return['data'] = $dormMap;
    	$return['AaS'] = $AaS;
    	$return['runTime'] = $runTime;


    	return $return;
		
	}


	//k最近邻算法
	public function KNN(){
		$timeStart = $this->getMicrotime();
		$stus = $this->student_list;
		$dormList = $this->dormList;
		$n = $this->n;
		$MathModel = new \app\common\librarie\MathModel();

		$dormMap = [];
		$MRList = [];
		//随机分m/n个学生到不同宿舍
		foreach ($dormList as $key => $value) {
			$stu = $this->random($stus);
			$dormMap[$value]['stus'][] = $stu['value'];
			$dormMap[$value]['MR'] = 0;
			array_splice($stus,$stu['key'],1);
		}
		
		//安排剩下的学生
		$count = count($stus);
		for($i = 0;$i<$count;$i++){
			$maxMatch = 0;
			$maxDorm = 0;
			foreach ($dormMap as $key => $value) {
				if(count($value['stus']) >= $n) continue;
				else{

					//把第一个学生放进宿舍内
					$afterUStudents = $dormMap[$key]['stus'];
    				$afterUStudents[] = $stus[0];
    				//计算该数组内学生的匹配度
    				
	    			$result = $MathModel->dormMR($afterUStudents);
	    			if ($result>$maxMatch) {
	    				$maxDorm = $key;
	    			 	$maxMatch = $result;
	    			}
				}
			}
			$dormMap[$maxDorm]['stus'][] = $stus[0];
			$dormMap[$maxDorm]['MR'] = $maxMatch;
			array_splice($stus,0,1);
			
		}

		foreach ($dormMap as $key1 => $value1) {
    		$item = [];
    		$MRList[] = $value1['MR'];

    		foreach ($value1['stus'] as $key2 => $value2) {
    			$item[] = $value2['number'];
    		}
    		
    		$dormMap[$key1]['stus'] = $item;
    	}
    	
    	$AaS = $this->AveAndSta($MRList);
    	$timeEnd = $this->getMicrotime();
    	$runTime = $timeEnd - $timeStart;
    	$LMRN = $this->countLMRN($MRList,$AaS['average']);
    	$return['LMRN'] = $LMRN;


    	$return['data'] = $dormMap;
    	$return['AaS'] = $AaS;
    	$return['runTime'] = $runTime;


    	return $return;
		
	}
	//改进k最近邻算法
	public function NKNN($stus = '',$dormList = '',$n = ''){
		$timeStart = $this->getMicrotime();
		!empty($stus)?$stus = $stus :  $stus = $this->student_list;
		!empty($dormList)?$dormList = $dormList :  $dormList = $this->dormList;
		!empty($n)?$n = $n :  $n = $this->n;
		
		$MathModel = new \app\common\librarie\MathModel();

		$dormMap = [];
		$MRList = [];
		//随机分m/n个学生到不同宿舍
		foreach ($dormList as $key => $value) {
			$stu = $this->random($stus);
			$dormMap[$value]['stus'][] = $stu['value'];
			array_splice($stus,$stu['key'],1);
		}
		
		//安排剩下的学生
		$count = count($stus);
		$index = 0;
		for($i = 0;$i<$count;$i++){
			$maxMatch = 0;
			$maxDorm = 0;
			foreach ($dormMap as $key => $value) {
				
				

				//把遍历学生放进宿舍内
				$afterUStudents = $dormMap[$key]['stus'];
				$afterUStudents[] = $stus[$index];
				//计算该宿舍内学生的匹配度
				
    			$result = $MathModel->dormMR($afterUStudents);
    			if ($result>$maxMatch) {
    				$maxDorm = $key;
    			 	$maxMatch = $result;
    			}
				
			}
			if(count($dormMap[$maxDorm]['stus']) >= $n) $index++;
			else{
				$dormMap[$maxDorm]['stus'][] = $stus[$index];
				$dormMap[$maxDorm]['MR'] = $maxMatch;
				array_splice($stus,$index,1);
			}
			
		}

		
		//将两种学生找出来
		$dormList2 = [];
		foreach ($dormMap as $key1 => $value1) {
			if(count($value1['stus'])<$n){
				foreach ($value1['stus'] as $key2 => $value2) {
					$stus[] = $value2;
				}
				$dormList2[] = $key1;
				unset($dormMap[$key1]);
			}
		}
		
		//整理封装数据
    	$dormMap = $this->arrange($dormMap);

    	//重组数据分配
		if(count($stus)>=(count($stus)/$n)*($n-1)){
			//执行KNN
			$data = $this->KNN($stus,$dormList2,$n);
		}else{
			//执行NKNN
			$data = $this->NKNN($stus,$dormList2,$n);
		}
		$dormMap = array_merge($dormMap,$data['data']);
		
		//封装返回数据
		$MRList = [];
		foreach ($dormMap as $key => $value) {
			$MRList[] = $value['MR'];
		}
    	$AaS = $this->AveAndSta($MRList);
		$timeEnd = $this->getMicrotime();
    	$runTime = $timeEnd - $timeStart;
    	$LMRN = $this->countLMRN($MRList,$AaS['average']);
    	$return['LMRN'] = $LMRN;

    	$return['data'] = $dormMap;
    	$return['AaS'] = $AaS;
    	$return['runTime'] = $runTime;


    	return $return;
		
	}
	//随机选择
	public function random($list){
		$stuId = rand(0,count($list)-1);
		$data = ['key' => $stuId,'value' => $list[$stuId]];
		return $data;
	}


	//贪心算法
    public function greedy(){
    	
    	$timeStart = $this->getMicrotime();
    	$n = $this->n;
    	$MathModel = new \app\common\librarie\MathModel();
    	$stus = $this->student_list;
    	$dormMap = [];
		$MRList = [];
    	foreach ($this->dormList as $key => $value) {
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
    				
	    			$result = $MathModel->dormMR($afterUStudents);	
	    			if ($result>$maxMatch) {
	    			 	$maxNum = $k;
	    			 	$maxMatch = $result;
	    			}
    			 }
    			 //最好的匹配对象学号在$maxNum中
    			 //扔进该宿舍集合，并从原待分配中数组移出
    			$dormMap[$value][] = $stus[$maxNum];
    			unset($stus[$maxNum]);
    			if($i == 2 || count($stus) == 0){
    				$MR = $maxMatch;
    			}

    		}
			$MRList[] = $MR;
			$dormMap[$value]['MR'] = $MR;
    		
    	}

    	//整理封装数据
    	foreach ($dormMap as $key1 => $value1) {
    		$item = [];
    		$MR = $value1['MR'];
    		for ($i=0; $i < $n ; $i++) { 
    			if(isset($value1[$i])){
    				$item[] = $value1[$i]['number'];
    			}
    		}
    		
    		$dormMap[$key1] = ['MR'=>$MR,'stus'=>$item];
    	}
    	
    	//记录
    	$AaS = $this->AveAndSta($MRList);
    	$timeEnd = $this->getMicrotime();
    	$runTime = $timeEnd - $timeStart;

    	$LMRN = $this->countLMRN($MRList,$AaS['average']);
    	$return['LMRN'] = $LMRN;

    	$return['data'] = $dormMap;
    	$return['AaS'] = $AaS;
    	$return['runTime'] = $runTime;


    	return $return;
    }

    //贪心算法
    public function greedyByargu($stus,$waitdormList){
    	
    	$timeStart = $this->getMicrotime();
    	$n = $this->n;
    	$MathModel = new \app\common\librarie\MathModel();
    	$dormMap = [];
		$MRList = [];
    	foreach ($waitdormList as $key => $value) {
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
    				
	    			$result = $MathModel->dormMR($afterUStudents);	
	    			if ($result>$maxMatch) {
	    			 	$maxNum = $k;
	    			 	$maxMatch = $result;
	    			}
    			 }
    			 //最好的匹配对象学号在$maxNum中
    			 //扔进该宿舍集合，并从原待分配中数组移出
    			$dormMap[$value][] = $stus[$maxNum];
    			unset($stus[$maxNum]);
    			if($i == 2 || count($stus) == 0){
    				$MR = $maxMatch;
    			}

    		}
			$MRList[] = $MR;
			$dormMap[$value]['MR'] = $MR;
    		
    	}

    	//整理封装数据
    	foreach ($dormMap as $key1 => $value1) {
    		$item = [];
    		$MR = $value1['MR'];
    		for ($i=0; $i < $n ; $i++) { 
    			if(isset($value1[$i])){
    				$item[] = $value1[$i]['number'];
    			}
    		}
    		
    		$dormMap[$key1] = ['MR'=>$MR,'stus'=>$item];
    	}
    	
    	//记录
    	$AaS = $this->AveAndSta($MRList);
    	$timeEnd = $this->getMicrotime();
    	$runTime = $timeEnd - $timeStart;

    	$LMRN = $this->countLMRN($MRList,$AaS['average']);
    	$return['LMRN'] = $LMRN;

    	$return['data'] = $dormMap;
    	$return['AaS'] = $AaS;
    	$return['runTime'] = $runTime;


    	return $return;
    }


	//普通算法
    public function ordinary(){
    	$timeStart = $this->getMicrotime();
    	$n = $this->n;
    	$MathModel = new \app\common\librarie\MathModel();
		$stus = $this->student_list;
    	$dormMap = [];
		$MRList = [];
    	foreach ($this->dormList as $key => $value) {
    		if(count($stus) == 0){
				break;
			}
    		$MR = 0;
    		for ($i=0; $i < $n; $i++) {
    			if(count($stus) == 0){
    				$MR = $MathModel->dormMR($dormMap[$value]['stus']);


	    			break;
	    		}
	    		
	    		foreach ($stus as $k => $val) {
	    			$dormMap[$value]['stus'][] = $val;
	    			unset($stus[$k]);

	    			break;
				}

				if($i == $n-1){
					$MR = $MathModel->dormMR($dormMap[$value]['stus']);	
				}
    		}

    		$MRList[] = $MR;
    		$dormMap[$value]['MR'] = $MR;
		}

		foreach ($dormMap as $key1 => $value1) {
    		$item = [];
    		$MRList[] = $value1['MR'];
    		foreach ($value1['stus'] as $key2 => $value2) {
    			$item[] = $value2['number'];
    		}
    		
    		$dormMap[$key1]['stus'] = $item;
    	}

		$AaS = $this->AveAndSta($MRList);
		$timeEnd = $this->getMicrotime();
    	$runTime = $timeEnd - $timeStart;

		$LMRN = $this->countLMRN($MRList,$AaS['average']);
    	$return['LMRN'] = $LMRN;


    	$return['data'] = $dormMap;
    	$return['AaS'] = $AaS;
    	$return['runTime'] = $runTime;

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

    //获取毫秒
    public function getMicrotime(){
    	$time = microtime();
    	$time = explode(' ',$time);
    	$time[0] = substr(explode('.',$time[0])[1],0,3);
    	$time = $time[1].$time[0];
    	return $time;
    }


    	//去除数组元素
	public function remove($list,$numList){
		foreach ($numList as $key => $value) {
			unset($list[$value]);
		}
		foreach ($list as $key => $value) {
			foreach ($numList as $key1 => $value1) {
				unset($value[$value1]);
			}
			$list[$key] = $value;
		}
		return $list;
	}
	//较大匹配学生选择
	public function MRMax($list1,$list2){
		$arr1 = $list1['MR'];
		$arr2 = $list2['MR'];
		$max1 = 0;
		foreach ($arr1 as $key => $value) {
			if($max1 == 0) $max1 = $value;
			else if($value>$max1) $max1 = $value;
		}
		$max2 = 0;
		foreach ($arr2 as $key1 => $value) {
			if($max2 == 0) $max2 = $value;
			else if($value>$max2) $max2 = $value;
		}

		return $max1>$max2?$list1:$list2;
	}

	//整理出宿舍安排
	public function arrange($data){
		
		foreach ($data as $key1 => $value1) {
    		$item = [];
    		$MRList[] = $value1['MR'];

    		foreach ($value1['stus'] as $key2 => $value2) {
    			$item[] = $value2['number'];
    		}
    		
    		$data[$key1]['stus'] = $item;
    	}

    	return $data;
		
	}


	public function countLMRN($MRlist,$MRave)
	{
		$count= 0 ;
		foreach ($MRlist as $key => $value) {
			if ($value<=($MRave*0.8)) {
				$count++;
			}
		}
		return $count;
	}
}