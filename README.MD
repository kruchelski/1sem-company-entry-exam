# ALGORITHM PROJECT ASSIGNMENT - COMPANY ENTRY EXAMINATION SIMULATOR  

## This assignment is for practicing some algorithms using the Pascal language for the first semester's Algorithm project course  
---

### Description  
This is a simulation of a Company Entry Examination. In this scenario the company's name is ENLATADOS. The idea of the assignment is to create some functions to read candidate's info from a .txt file, then rewrite the info in an indexed file. Then, the program must be able to sort the candidate list by a variety of atributes (inscription number, name, etc). The program simulates the answers of the candidates in the exam and must let the user input an correct answers template so the program can calculate the grades of each candidate in the test. In the end it must show some info about the results (like best results in general, by subject and etc.).  

### Instructions  
This simulation is divided in 6 exercises. Each exercise represent a step for the correct and total work of the assignment. In addition, there are some text files and pascal files for support. So, here is the exaplanation of each file:  
- MODULOS.PAS: Pascal file with some sort and search functions and some records for use in the main program
- LEDIR.PAS: A Pascal file with a function for creating the template for printing the info about the candidate list
- N01T01.pas: The first exercise. The objective here is to implement the funcitons for the MODULOS.pas
- N01T02.pas: Generate the CAND.ind file
- CAND.ind: This file is the candidate list in an indexed format. It was generated from the cand.txt
- cand.txt: A text file with all the info of the every candidate in the exam.  
- N01T03.pas: Exercise to print the candidate list in a ordered way, which can be one from a set of categories.
- N01T04.pas: A module for correction of the test (in this exercise, the user can input the correct answers template which will be used by the program to evaluate the candidates's tests)  
- N01T05.pas: The system calculates the position of each candidate according to the area and in general  
- N01T06.pas: Another sorting program in which is possible to print the results according to a specific sorting attribute.
- prova1.txt, prova2.txt and VAGAS.txt: support files with the information of the exam and candidates's answered tests.  

### Final considerations  
All of these little programs were made and executed in the [Pascal Zim compiler](http://www.pascalzimbr.blogspot.com/p/blog-page.html)  

**important**: This was made for studing purposes. I create this repository for sharing the solutions with colleagues and everyone else who may find this useful. This doesn't mean it's the only or the best solution. Feel free to sugest and colaborate.
