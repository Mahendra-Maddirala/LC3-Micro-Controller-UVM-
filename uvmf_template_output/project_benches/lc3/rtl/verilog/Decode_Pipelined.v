`include "data_defs.v"
module Decode(clock, reset, enable_decode, dout, E_Control, npc_in, //psr, 
	      Mem_Control, W_Control, //F_Control, 
	      IR, npc_out); 

   input 			clock, reset, enable_decode;
   input [15:0] 		dout;
   //input 	[2:0] 	psr;
   input [15:0] 		npc_in;
   output [1:0] 		W_Control; 
   output 	 		Mem_Control;
   output [5:0] 		E_Control;
   output [15:0] 		IR;
   output [15:0] 		npc_out;
   //output 			F_Control;
   
   reg [1:0] 			W_Control; 
   reg 				M_Control; 

   reg [1:0] 			inst_type;
   reg 				pc_store;
   reg [1:0] 			mem_access_mode;
   reg 				load;
   reg [1:0] 			pcselect1, alu_control;
   reg 				pcselect2, op2select;
   //reg 			br_taken;

   reg [15:0] 			IR, npc_out;

   
   wire [3:0] 			opcode=dout[15:12];

   //assign	F_Control = br_taken;
   // definition of controls and data
   assign 			Mem_Control	=	M_Control;
   assign 			E_Control	=	{alu_control, pcselect1, pcselect2, op2select};
   //assign 	F_Control	=	br_taken;

`pragma protect begin_protected
`pragma protect version = 1
`pragma protect author = "BobOden"
`pragma protect author_info = "ECE792-036"
`pragma protect encrypt_agent = "RTLC VELOCE", encrypt_agent_info = "1.5"
`pragma protect key_keyowner = "Mentor Graphics Corporation"
`pragma protect key_keyname =  "MGC-VERIF-SIM-RSA-1"
`pragma protect key_method = "rsa"
`pragma protect encoding = ( enctype =  "base64")
`pragma protect key_block
oSa91HzMUKklTYAl7o1VVbgkr9HQu8bkR/i4NaUF/SlPoxbILryovraVZsmZAs85
skHLPC/MxtbWY6kmVFa1MSV0FkZiSAQmAOhDKjElikrLXm4xd+MOzXdOErnpkp6G
mfaneO8S0qslQv4zk+pE3r/VCDiLYIuc4xMLoo9EjQM=
`pragma protect key_keyowner = "Mentor Graphics Corporation"
`pragma protect key_keyname =  "MGC-VELOCE-RSA"
`pragma protect key_method = "rsa"
`pragma protect encoding = ( enctype =  "base64")
`pragma protect key_block
UdKOJ3c9H5eq87XDjq3YN95HCMmq/X+nkzczdVqAnpjnByekVLQl4QxUIo4hRLTA
WzPd1nF+ftfO8ZI+QC4o98PRqnyoaXqgIFXhTS0AaeTm9rvSD3fQrHmwwMVMMEe7
+xGzeFF3rpEEzglBt4xlqj9PT2fOXx2rhSSY8/1dCrM=
`pragma protect data_method =  "aes128-cbc"
`pragma protect encoding = ( enctype =  "base64" )
`pragma protect data_block
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
eHbCRXVoYJb/p4L8c6PFZMWsM0RHS1nqZoqDHpyfP+yXa0H/Q8ksiu+SI9An8nsC
KXZczg2727pYurO+H1QJutgER/OS2CWLIv5spV/DCADTJYPbV4omg9qvSkuTSdK2
kIDC/UyVXkeZy0tL9HZkzUxvLIwinFQx+b30yaN8WnnXzHYfAMiCff//TX2CGL+p
0FXJEZgY4eATiSBxC+mv9iSQIq7lZDrhoHi5PiMz8psb2BkN0B1TIDBWkL5dcfR7
u8Hfp7/WDfbkebqmPrOIWi84Rl43OgArTVcxM8wHKhkjW9Y9R4JdVPEjgLy+vN8l
02G9lMBI6acEYO2ly0qW3VwS8l2PEdbFyhMbqdyQZPf4uxWxZJSKWK3bdd/QpqSj
XkEJro6cXtmM07XXciWa+i+bajIH/FY8IWEwjDFezGYJFnQwWgVSjUNrY4mMrXFm
ISYivr2+bOLosuhnWi91cTfwXDDS/S1aeVze4mJRmLXkx2mwJT4OjEi/TMDI4Cr+
+dsj5eNVMngjbDhOM976e9/6XaXwqveSij/3j8xUSH7pYF4nKyEn40/x3bz+Hq0j
Nvydgd4G9iG1b7Y+ehwXUbtz90/ZOLc+Pj8sXTInZv/CpBU+v3kJ6lrLQiwgoT/H
KS/tncsj1c8sQHNaxI/Resc7oUpvm121KeQfJuQbPbZq7GepxTjVcoXOu5qg9ObZ
pLy+c0lGjXTZOhP3a+WjUXOXhRDi/1crTrVvamni37634JmYFinQurw7GpjzgQl0
FKgjmtBZmr5laASh9/Qqd6lfU9axZrTS/YbRzvciu0hmljb6lRVChimM7y/pShKO
OKdPpq0HTAGGxbiqCM6TSWaU7C8Vj3/SX1Bz8/o5wQLiRtEf3A0KC0xA9i0k4OCv
4cf5LTQ6emBzt9tI0xmdVwIhlQvNll1VdwqPn6XKKdtu+aN1znwpF+EomF9G2fqL
KgRGSX3rVeLTQHYRHYba/aFFF/s/+LAaIjhNXSBSV3cK+lnTdztwoTDqi/WJyHHz
XkpQ2abVzGxqE3jHvVKRNP1IZwx17j/4eVq8bLiPjasPkX76PtVm2bs5ykSznS4F
u8lOhsp3osmon7S7S2I9fCC2KLF4w1ivj5AGLlhJJYQIUOuGWV5ZU1h0uSppoQ4o
4twqZGKu70Qt3eyWkKAT4lo6kX58czcK4/Jv4nJdzr4ZoRbV3ygzu0UaOy2VLbio
8+XI9UWOIg0OwN+KTldZBghNLK2JOeWls6HyVjsrSzZ79Bb//hJ5PVXMy9kW3cQM
azRqFW4Umx/Ete3mT60CI4nwySQg1qPV8nHrip99a7GqqTnxwFZgs4987ZssGfRC
cnKNSMFrTf5TIhlTD45rBLTKmPhguGvfba52bDerD4WGS5A1NiuknC9UZJx5sApA
4mlzv8AdHMAnFzyHResyxCqJ8t7b7tSWb7hsPTTldSdOMcI5fuk43WWdRg+5m2Sk
kjlZuj69/nnwqn93eVgqHGjRcCrGOLW45YFW8x8laRHzIizIWWjS2uTmSj8YWxDQ
IqDEOJSa2Manl80PiES/5S0TS+A62fEShP+3B1PZYhJaXdII38kWG7W+qYlIEIoY
q628X6p3uZ+siXpYQOyKN3XNMrr8qXScqJwS77irD123zJH1PXmQWRFIPP5xUTTc
sbrArffwSAth7UIc2qkhgxHzVGuKkDdxJ7dJtxVKobnihehx6r0dN5SRUyz28cfc
5rESgNpaRqFh/2psqkqpRX4jG7GU6d3gRsyXdbCZ7tfV6mA0n7tRzyM5fsgwKhLo
5LscAOgNBkYE2t954Xi2RfI+rquxsYJTQ/Lza1Sy6ETQ7wp9nrtwpfi82vGr3Dfk
iRALv0vHKk52bGdP8PuMvXsTWB4v8uaeCzV29lM8+TIqyLcjtQwkumgdaRz6B708
7KhNBq3a7jLXwjrBAVM69BiVwHikKyZ8t+hNYTOLwb4m9rnKYavwbDaaFz9r8OiR
E7ZjPUqtF2TSjb7965pYuBZeVBW17piW4oVjRY/CrkTcZL7Qvv+J2z0W3F1ceC0R
/RCoD2ojajKSpWnKH+CQxFQpFzFe7LhZaAb5TKm5zPPvtGITkhYjffI/+d9Io7Mh
8eLbnwowXCcSwjeVa6Lfp90bw7INJyaGiBX/2uULKrWMec6i7Wq0/zYLhGUqBffO
bdQQnGFf+C3GXMT1IY777zB8ZDNJ3YsnEtKcUyDy/o37BNJXsPRi6YNaSIDzE3wX
a0O0CR7GTnefOnnqljnUZApCt8idmaNvH/HDsCy0NioHePc/VdOvs9Dnww5RsR+8
VK5O5hnB0vtMVb0aaaJY22j/Aga76gx2TDuZd0DcL80b7dacuDlRJnCl+MUeiseD
s/1P+GpbhPkmtm3KwtQnLzz+MR9m99tzPe8ASSMnh+mEhpdnLlX/LONJyRQgyFSL
LD8mT2+ZMo7en6r7IVX8aT0kQMGO17quyvKFhDPMjSNRt2WmQ9FuceXaa71gh9YR
btDMo0eSj9T8Vg5vHdmZnO18rbKFzXnxqv37g8qofE1wxhSiz/gaK8+8ztPI8quv
fO8L3Jv4h/Y/RKlIFDk7uN2iMaR+o6kmnpnrUjr/c6TvqxKKchLY90iwgoIoWOQh
6VO17cW8eJHRPlGO9icnTYcddHfH+tiZ377HRswtlXgIKiVE7UjmOX8D19Pqqn64
Mtpy337mwDyBqbeLCwfScFvVEadeJZfDHToa/BTbs9euNgm8EqkmtUtci9uPVfTz
N+GoGDhMo9HggyZOgoWaVmNbfNq+dhlDFT2S8lPz2R6RMQEnUfiSJ1KWePuS3HtO
9E+4d4+6C/DVrj0maet67qvI0Ex6QUTn2cT+7GxA7cgiPE5/3aj5G5EKGVSWTUmI
qapVN0LlkRMzhuaFcroh5mMK5oLkb8EEufczbezhuCqAHL0MbSbeQtJzXR2ngSmu
bxNt4fAlFvux2iG9zpovTrGdI8saLtJ2lebx+LZDqqp70XnYlGF8Msjnz0Mv+oDC
BW1w+CM1PdB5j5qLI2P3oHHVXTf8iQwLxW6QB/XYBxRKslmC3aAgBobc7KSK/Aza
rc9DiKBZlOoWyt2nYhoWY9wgWzYjOwq0wbdTR/Tu7kMvAdzagQ2FkhtMymHlcpBI
qoVMgVQ26B4Bk7gUfuwgZEJ3xKSHVhyyijiPtf2J7egTtrSwYh2UgQmmPSZ3ZLLU
FjEX42QcbeuCw308YCM0iLTfyTelC0In2+oKfHMridQYY7pZ1pB6lXxo16LNrc8D
VkWLE++mzhIyAHbpYWvN8uSs1VINwcSPSEaj87do8YErAhfEGDlbccSkneIVkeCK
8e4R+gyUhz0Go91Byf5gVwrVxD5p4eJoTtgS0aHgQPsjghWPfRejrlskmt6y7Srh
hkmEPIl0t/+LMoe79aeba3RFQNOxyLj9YLWsyTwjiDsttpDXFM/z1wOevRDldPQ+
K/5dCOnapEppqeU8M03OvRXn5iOuxSoapDkFJXjT1xqWmIPmVVIVD0sPZNFiQDtx
e0hB0ux+iT9B3CwjcQ73Pnt8YauzfsyB7zil9OI05B/lk0VuAVG+9njl3KEBlESk
nWe1MKQgqL0iiYjVL6H8ID35iXJjgTKfLQJJxQIXbW2DbxJjTu1u+RVf7LiNqOnQ
SmE2IibbZcQ0vyUTS70KjY7JzhrcUTcc5QoV9u20Q26lxdavCQX2KfSaEmAMfnK9
g7Xuwf5guCKBv4tjURBoLy+gAXRjRKXEpX4NK5Us7X5FNUZ2ldU2OZhBWvaiPhgM
U/M0oQVNvHAShJc9DQLdLj6UMRpGEvkQ9QxWyvbWLfofvacg00X5s7yVLi0c/OOW
d/yjn/jVcNVkopQy+dLH5VrZfAvBCP+XnJVpdc1TXT0fNPTJDciGzxm9ITJaR+G4
S2eFdkpVlXJZUcBzdGn7bguK122Y9pmRJNoK4gZTbzu8w+Rh+C6wUdW5Ikdy9JxP
zxIWvizraj7kH5czIM8ofdXI4s7ja/C5F8gi3YFhJx7hyJuiKyfM8gUClrOEyojz
DQ3Y0UwWsiPxFaiZ2I2fGg==
`pragma protect end_protected
   
endmodule
