//#include <string>
#include <iostream>
//#include <vector>
//#include <ros/ros.h>
#include <SWI-Prolog.h>
#include<knowledge.h>


PREDICATE(find_dimension, 4){
       //std::string F((char*)PL_A1);
       //std::string M((char*)PL_A2);
       std::cout<<"The Second argument is: "<<(char *)PL_A2<<std::endl;
       std::cout<<"The Thirf argument is: "<<(char *)PL_A3<<std::endl;
       std::cout<<"The Forth argument is: "<<(char *)PL_A4<<std::endl;
       //std::cout<<"The second argument is: "<<(char *)PL_A2<<std::endl;
    return true;
}

//PREDICATE(grasping_pose,4){
//    std::cout<<"This is X value of quternian = "<<(char *)PL_A2<<std::endl;
//return true;
//}


//PREDICATE(object_dimension,4){
////    int  (char *)PL_A2 =1 ;
////    int  (char *)PL_A3 = 2;
////    int  (char *)PL_A4 = 3;
//        std::cin<<(char *)PL_A2;
//        std::cin<<(char *)PL_A3;
//        std::cin<<(char *)PL_A4;

////    void
////    assertWord(const char *word);
////    { PlFrame fr;
////      PlTermv av(1);
////      av[1] = PlCompound("word", PlTermv(word));
////      PlQuery q("assert", av);
////      q.next_solution();
////    }


//    return true;
//}





////PREDICATE(find_physical_attributes, 4){

////   std::string parameterName((char *)PL_A2);
////   std::cout<< "The sencond argument after reading from pl IS: "<<(char *)PL_A2<<std::endl;
//////   A3=4;
//////   std::cin>>(char *)A3;

////   return true;
////}
////PREDICATE(getPose, 3){

////    std::cout<<"asserting Poses" << std::endl;

////    A1 = "Sensing values 0.0";


////    std::cout<< "GraspingPose01 Prolog Input"<< (char *)A2 << std::endl;
////    std::cout<< "GraspingPose02 Prolog Input"<< (char *)A3 << std::endl;

////    return true;
////}

////PREDICATE(add, 3)
////{   A1=2;
////    A2=3;
////    std::cout<<"A3 =A1+A2 = "<<(char *)A3<<std::endl;
////    return A3 = (long)A1 + (long)A2;
////}

////// variable, goal and average
////PREDICATE(average, 3)
////{ long sum = 0;
////  long n = 0;

////  PlQuery q("call", PlTermv(A2));
////  while( q.next_solution() )
////  { sum += (long)A1;
////    n++;
////  }
////  return A3 = (double)sum/(double)n;
////}

//// ****************************************************************************************************


