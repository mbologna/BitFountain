class Matrix(object):
    def __init__(self, rows, cols):
        self.cols = cols
        self.rows = rows
        self.matrix = []
        for i in xrange(rows):
            ea_row = []
            for j in xrange(cols):
                ea_row.append(0)
            self.matrix.append(ea_row)
 
    def setitem(self, row, col, v):
        self.matrix[row][col] = v
 
    def getitem(self, row, col):
        return self.matrix[row][col]
 
    def __repr__(self):
        outStr = ""
        for i in xrange(self.rows):
            outStr += 'Row %s = %s\n' % (i+1, self.matrix[i])
        return outStr
    
    def printer(self,v,v2):
        outStr = ""
        for i in xrange(v):
            outStr += 'deg=%d  f1=%d  %s\n' % (self.degree(i), self.firstOne(i), self.matrix[i][:v2])
        return outStr
 
    def setbit(self, row, col):
        self.matrix[row][col] = 1
        
    def tstbit(self, row, col):
        return self.matrix[row][col] == 1
    
    def getrow(self,row):
        return self.matrix[row]
    
    def firstOne(self,row):
        if 1 in self.getrow(row):
            return self.getrow(row).index(1)
        else:
            return -1
    
    def degree(self,row):
        count = 0
        for bit in self.getrow(row):
            if bit == 1:
                count +=1
        return count