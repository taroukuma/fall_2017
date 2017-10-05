def al_mult(x, y):
    #does the multiplication al's way
    
    if (x == 0):
        return 0

    z = al_mult(x//2, y)

    if (x//2 == 0):
        return 2*z
    else:
        return (x + 2*z)
    return


#the function call:
print(al_mult(12, 3))
print("hello world!")
print(name)

    
    
