#include<iostream>
#include<knowledge.h>
#include <SWI-Prolog.h>
#include <SWI-cpp.h>
#include<ros/ros.h>
// here load the Pl environment and file please
//PREDICATE(like,2){
//    std::cout<<"The second argument is: "<<(char *)PL_A2<<std::endl;
//    return true;
//}
string Knowledge::prologPath="";

void Knowledge::prologEnv()
{
    string loadFile;
    loadFile = "consult('";
    loadFile += prologPath;
    loadFile += "')";

    const char * argv [] = {" -q "};

    // Opening the Prolog environment.
    cout<<"Prolog file has been loaded from the directory: "<<prologPath<<endl;
    PlEngine e(1, (char **) argv);

    // Loading the Prolog file.
    PlCall(loadFile.c_str());
}

//
bool Knowledge::setKnowledge()
{
    vector<string> obj;
    vector<string> objType;

    obj.clear();
    objType.clear();

    string loadFile;
    loadFile = "consult('";
    loadFile += prologPath;
    loadFile += "')";

    const char * argv [] = {" "};

   PlEngine e(1, (char **) argv);

    // Loading the Prolog file.
    PlCall(loadFile.c_str());}

// ******************** Define the prolog Predicate ********************************



int main()
{
    Knowledge owlKnowledge;
    owlKnowledge.setPath("home/diab/catkin_ws/src/interfaceprologcpp/prolog/knowledge.pl");
    std::cout<<owlKnowledge.getPath();
    owlKnowledge.prologEnv();
   }
