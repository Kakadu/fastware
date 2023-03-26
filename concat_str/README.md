
```
Concatenating 4 long (100000) strings.
                  Rate Printf.sprintf    ^ Format.sprintf Manual buffer String.concat
Printf.sprintf 10139/s             -- -27%           -34%          -50%          -80%
  String.( ^ ) 13903/s            37%   --            -9%          -32%          -72%
Format.sprintf 15357/s            51%  10%             --          -25%          -69%
 Manual buffer 20413/s           101%  47%            33%            --          -59%
 String.concat 50254/s           396% 261%           227%          146%            --
Concatenating 4 short (10) strings.
                     Rate Format.sprintf Printf.sprintf String.concat Manual buffer    ^
Format.sprintf  3904456/s             --           -75%          -85%          -85% -85%
Printf.sprintf 15356925/s           293%             --          -39%          -41% -42%
 String.concat 25263415/s           547%            65%            --           -3%  -4%
 Manual buffer 25914983/s           564%            69%            3%            --  -2%
  String.( ^ ) 26438018/s           577%            72%            5%            2%   --
Concatenating 10 long (100000) strings.
                 Rate String.( ^ ) manual Buffer Printf.sprintf Format.sprintf String.concat
  String.( ^ ) 1964/s           --          -33%           -68%           -68%          -69%
 manual Buffer 2922/s          49%            --           -53%           -53%          -54%
Printf.sprintf 6153/s         213%          111%             --            -0%           -4%
Format.sprintf 6168/s         214%          111%             0%             --           -4%
 String.concat 6402/s         226%          119%             4%             4%            --
Concatenating 10 short (10) strings.
                     Rate Format.sprintf Printf.sprintf String.( ^ ) String.concat manual Buffer
Format.sprintf  2152231/s             --           -67%         -76%          -77%          -84%
Printf.sprintf  6437099/s           199%             --         -29%          -31%          -52%
  String.( ^ )  9041243/s           320%            40%           --           -3%          -32%
 String.concat  9363712/s           335%            45%           4%            --          -30%
 manual Buffer 13324518/s           519%           107%          47%           42%            --
```

```
✗ cat /proc/cpuinfo | /usr/bin/grep 'model name' | head -n1
model name      : Intel(R) Core(TM) i7-4790K CPU @ 4.00GHz
````
