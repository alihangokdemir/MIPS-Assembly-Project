# MIPS-Assembly-Project

INTRODUCTION :
	The MIPS Assembly Code contains some procedures and it provides user to do some operations that are asked from the instructor.
PROCEDURES :
1-delete (list, str, type) 
	This procedure gets inputs that are defined in the data segment.These are list , type and str.If type is equal to 0.The procedure workstyle is when the substring found in the list it shifts the list to the left.Shift count depends on the substring length and after it exits from the program.If type is equal to 1.Same operation is going to happen but do not exit from the program it will continue until the list shows the null value.
2-replace(list,str1,str2)
	This procedure gets inputs that are defined in the data segment.These are list , str1 and str2.The procedure workstyle is it gets the str1 value which is desire to change with str2 value and it searches in the list when the program finds the str1.It replaces with str2 and the operation is continue until see the null value of the list.
3-convertCase(input_list, output_list) 
	This procedure gets input list that are defined in the data segment.The procedure workstyle is it gets input list elements one by one and subtract with 32 number  if it is between a and z ascii characters so it shows the Upper case of the changed value. (32 number calculated from the ASCII table.The differences between uppercase and lowercase letters is 32). 
4-convertNumber(input_list,output_list,type)
	This procedures gets type and input list from the data segment.If the type is equal to 1.Depends on the starting value of the binary number it executes operations.If the number starts with value 1,It gets the elements one by one when the program sees the value 0.It subtracts the sum with exponents of 2’s , to the sum based on the element place and finally subtract with 1 and returns the sum.If the number starts with value 0 , It gets input list’s elements one by one when see the value 1.It adds exponents of 2 to the sum based on the element place and returns the sum.
	If the type is equal to 2 , The loop gets the input list’s elements one by one and prints the value of four bits each time.When it sees the value 1.It adds to the sum the value of 2’s exponents based on element place and returns the sum.
5- sortchar(input_list,output_list,type)
	The procedure workstyle is it gets elements of the input list one by one and it compare first element to all of them and if the first one is greater than the others it swaps.The operation is same for next elements.After it sees the null value it returns the sorted elements.
6-sortInt(input_list,output_list)
	The procedure workstyle is it gets elements of the input list and compare first element with all of them if the compared number is greater than other one it swaps the numbers and the operation is same for next elements.Finally it returns the sorted list.
7-compareString(str1,str2)
	The procedure workstyle is it gets strings one by one and compare first elements of the str1 and str2.If they are equal it continue to do same operation.When the elements are not equal it returns the result depends on the lexicographical order. 
	
