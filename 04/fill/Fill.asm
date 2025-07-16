// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

@24576  // キーボードの入力状態
D=M     // キーが押されていれば D ≠ 0

(LOOP)
	@24576
	D=M      // キーの状態をDに取得
	@BLACK
	D;JNE    // D ≠ 0 → キーが押されている → BLACK処理へ

(WHITE)
	@0
	D=A
	@i
	M=D      // i = 0（インデックス初期化）
	
	@16384
	D=A
	@addr
	M=D      // addr = SCREENの先頭アドレス

(WHITE_LOOP)
	@i
	D=M
	@8192
	D=D-A
	@END_FILL
	D;JEQ    // i == 8192なら終了
	
	@addr
	A=M
	M=0      // 画面のこの語を白に（0に）する
	
	@addr
	M=M+1    // addr++
	@i
	M=M+1    // i++
	@WHITE_LOOP
	0;JMP

(BLACK)
	@0
	D=A
	@i
	M=D      // i = 0

	@16384
	D=A
	@addr
	M=D      // addr = SCREEN

(BLACK_LOOP)
	@i
	D=M
	@8192
	D=D-A
	@END_FILL
	D;JEQ
	
	@addr
	A=M
	M=-1     // 黒に塗る（全ビット1）
	
	@addr
	M=M+1
	@i
	M=M+1
	@BLACK_LOOP
	0;JMP

(END_FILL)
	@LOOP
	0;JMP    // メインループに戻る