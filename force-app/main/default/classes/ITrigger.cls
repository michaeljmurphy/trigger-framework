/**********************************************************************
 Name:  ITrigger
 Copyright © 2015
 ======================================================
======================================================
Purpose:  DESC: interface to prototype methods used in trigger helper classes
                interface is also used for dispatcher functionality.
-------                                                             
======================================================
======================================================
History                                                            
-------                                                            
VERSION      AUTHOR                DATE             DETAIL             Description
   1.0    Michael Murphy        09/09/2015     INITIAL DEVELOPMENT        
***********************************************************************/  

public interface ITrigger {
     /* for every class the first thing that
      * should be overriden is this method.  this
      * determines whether the class runs
      * and filters the records passed for 
      * logic to by applied.  This has no parameters.
      * Constructors should be overriden to pass params.
      * */
      void filterRecords();
         
     /* this method should be used to do the logic 
      * for every class.  before this is called,
      * records must be filtered by whatever criteria
      * is necessary in order to reduce the batch size 
      * */
      void execute();
}