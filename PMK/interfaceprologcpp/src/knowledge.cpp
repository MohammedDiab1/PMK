
// Include Prolog header files used to incorporate the OWL knowledge
#include <knowledge.h>
#include <SWI-Prolog.h>
#include <SWI-cpp.h>


string Knowledge::prologPath=" ";

void Knowledge::prologEnv()
{
    string loadFile;
    loadFile = "consult('";
    loadFile += prologPath;
    loadFile += "')";

 //   char **argv;
   // argv[0] = " ";
 //   const char * argv [] = {"swipl.dll","-s",NULL};

    const char * argv [] = {" -q "};

    // Opening the Prolog environment.
    cout<<"ppaaaathhhhhhh isassssssssssss : "<<prologPath<<endl;
    PlEngine e(1, (char **) argv);

    // Loading the Prolog file.
    PlCall(loadFile.c_str());

}

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

    string constraint;

 //   char **argv;
   // argv[0] = " ";
    const char * argv [] = {" "};

    // Opening the Prolog environment.
    cout<<"Prolog path is : "<<prologPath<<endl;
   PlEngine e(1, (char **) argv);

    // Loading the Prolog file.
    PlCall(loadFile.c_str());

    // Setting the Prolog query over the OWL knowledge.
      PlTermv termAOC(4);
      PlQuery qAOC("all_object_classification", termAOC);
      while (qAOC.next_solution())
      {
       constraint.clear();
       cout << (char*)termAOC[0] << endl;
       cout << (char*)termAOC[1] << endl;
       cout << (char*)termAOC[2] << endl;
       cout << (char*)termAOC[3] << endl;

       constraint = (char*)termAOC[3];

       OWLKnow[(char*)termAOC[1]].name = (char*)termAOC[1];
       OWLKnow[(char*)termAOC[1]].type = (char*)termAOC[2];

       if(constraint == "cont-manip-const")
       {
           cout << "cont-manip-const found !!!"<<endl;
           PlTermv termFMC(2);
           termFMC[0] = (char*)termAOC[0];
           PlQuery qFMC("find_manip_const", termFMC);

           while (qFMC.next_solution())
           {
               cout << (char*)termFMC[1] << endl;

               OWLKnow[(char*)termAOC[1]].manipConst.push_back((char*)termFMC[1] );
           }

           PlTermv termFCC(2);
           termFCC[0] = (char*)termAOC[0];
           PlQuery qFCC("find_cont_const", termFCC);

           while (qFCC.next_solution())
           {
               cout << (char*)termFCC[1] << endl;

               OWLKnow[(char*)termAOC[1]].contConst.push_back((char*)termFCC[1] );
           }

       }

       else if(constraint == "manip-const")
       {
           cout << "manip-const found !!!"<<endl;
           PlTermv termFMC(2);
           termFMC[0] = (char*)termAOC[0];
           PlQuery qFMC("find_manip_const", termFMC);

           while (qFMC.next_solution())
           {
               cout << (char*)termFMC[1] << endl;

               OWLKnow[(char*)termAOC[1]].manipConst.push_back((char*)termFMC[1] );
           }

       }

       else if(constraint == "cont-const")
       {

           cout << "cont-cost found !!!"<<endl;
           PlTermv termFCC(2);
           termFCC[0] = (char*)termAOC[0];
           PlQuery qFCC("find_cont_const", termFCC);

           while (qFCC.next_solution())
           {
               cout << (char*)termFCC[1] << endl;

               OWLKnow[(char*)termAOC[1]].contConst.push_back((char*)termFCC[1] );
           }

       }

       obj.push_back((char*)termAOC[1]);
       objType.push_back((char*)termAOC[2]);

      }

      setObject(obj);
      setObjecType(objType);

//            PL_cleanup(st);

    return true;
}
