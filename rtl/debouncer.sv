module debouncer #(

  // Счетчик, который будет считать время, которое сигнал вел себя стабильно
  // Если это время достигнет 2**DB_CNT_W - 1 -- им можно пользоваться.
  
  parameter GLITCH_TIME_NS = 10, //порог срабатывания кнопки DB_CNT_W
  parameter CLK_FREQ_MHZ = 150000000 //частота модуля
) (
  input  logic clk_i,
  //input  logic s_rst_i,

  input  logic key_i,             //pin_i
  output logic key_pressed_stb_o  //pin_state_o
);

// pin_i асинхронный сигнал. Нужно его пересинхронизировать:

logic [2:0] key_d;

always_ff @( posedge clk_i )
  begin
    key_d[0] <= key_i;
    key_d[1] <= key_d[0];
    key_d[2] <= key_d[1];
  end

logic [GLITCH_TIME_NS-1:0] db_counter;
logic                      key_differ;

logic                      db_counter_max;

// 1 только когда счетчик станет '1111...11
assign db_counter_max = ( &db_counter );

// 0 -- когда пин не меняется за 2 такта
// 1 -- пин на двух тактах имеет разное значение
assign key_differ = key_d[2] ^ key_d[1];

always_ff @( posedge clk_i )
 // if( s_rst_i )
 //  db_counter <= '0;
 // else
    begin
      if( db_counter_max || key_differ )
        db_counter <= '0;
      else
        db_counter <= db_counter + (GLITCH_TIME_NS)'(1);
    end

always_ff @( posedge clk_i )
  //if( s_rst_i )
   // key_state_o <= 1'b0;
 // else
    if( db_counter_max )
      key_pressed_stb_o <= key_d[2];

endmodule
