<?php
namespace app\common\librarie;
use think\Db;
class MathModel
{
    private $expensesN = 5;
    private $WaRN = 3;
    private $hygieneN = 3;
	//两个学生之间匹配度
    public function bothMR($stuA,$stuB)
    {
        // dump($stuA);
        // dump($stuB);
        $MRAB = $this->MR($stuA,$stuB);
        $MRBA = $this->MR($stuB,$stuA);
        $return = ($MRAB+$MRBA)/2;
        $return = $this->floattopercent($return);
        return $return;
    }

    //两个学生之间单向匹配度
    public function MR($stuA,$stuB)
    {

        $dc['atmosphere'] = $this->DC($stuA['atmosphere2'],$stuB['atmosphere'],'atmosphere');
        $dc['hygiene'] = $this->DC($stuA['hygiene2'],$stuB['hygiene'],'hygiene');
        $dc['vice'] = $this->DC($stuA['vice2'],$stuB['vice'],'vice');
        $dc['WaR'] = $this->DC($stuA['WaR2'],$stuB['WaR'],'WaR');
        $dc['electric_contest'] = $this->DC($stuA['electric_contest2'],$stuB['electric_contest'],'electric_contest');
        $dc['hobby'] = $this->DC($stuA['hobby2'],$stuB['hobby'],'hobby');
        $dc['from'] = $this->DC($stuA['from2'],$stuB['from'],'from');
        $dc['expenses'] = $this->DC($stuA['expenses2'],$stuB['expenses'],'expenses');

        $return = 0;
        foreach ($dc as $key => $value) {
            $return += $value*$stuA['w'.$key];
        }
        //计算总的权重
        $countOfw=0;
        foreach ($dc as $key => $value) {
            $countOfw +=$stuA['w'.$key];
        }
        if ($countOfw!=0) {
            $return = 1-$return/$countOfw;
        }
        else
        {
            $return = 1;
        }
        return $return;
    }

    //转百分数
    public function floattopercent($n) 
	{ 
	 	return ($n*100).'%'; 
	}

    //两个学生之间单项匹配度
    public function DC($D,$C,$str)
    {
        if(empty($D)){
            return 0;
        }
        if(empty($C)){
            if($str == 'expenses' || $str == 'WaR' || $str == 'hygiene'){
                $char = $str.'N';
                $count = $this->$char;
                $D = ($D-1)/($count-1);
                $return = ((1-$D)>$D)?(1-$D):$D;
                return $return;
            }
            return 1;
        }
        if($str == 'expenses' || $str == 'WaR' || $str == 'hygiene'){
            $char = $str.'N';
            $count = $this->$char;
            $D = ($D-1)/($count-1);
            $C = ($C-1)/($count-1);
            $return = ($C-$D)>($D-$C)?($C-$D):$D-$C;
            return $return;
        }
        else if($str == 'hobby'){
            $D = explode("_", $D);
            $C = explode("_", $C);

            $n = 0;
            foreach ($C as $key => $value) {
                if(in_array($value,$D)) $n++;
            }
            $return = 1-$n/count($D);
            return $return;
        }
        else{
            if($D == $C) return 0;
            return 1;
        }

    }


    public function dormMR($stuL){
        if(count($stuL) == 1)return 0;
        $MRZ = 0;
        $n = 0;
        for ($i=0; $i < count($stuL); $i++) { 
            for ($j=$i+1; $j < count($stuL); $j++) { 
                $MR = $this->bothMR($stuL[$i],$stuL[$j]);
                $MRZ += $MR;
                $n++;
            }
        }
        return round($MRZ/$n,4);;
    } 
}
