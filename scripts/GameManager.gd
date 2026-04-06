extends Node

# Referências aos nós que aparecem na sua foto
@onready var timer = $RelogioHistorico
@onready var map_data = $Map
@onready var country_data = $Map/ProvinceSelector/CountryData
@onready var label_data = $HUD/margin/Tempo/container/TextoData

# Variáveis de tempo
var dia = 1
var mes = 1
var ano = 1903
var pausa = false # Começa rodando ou pausado? Você escolhe.

# Nomes dos meses em Espanhol para o seu trabalho
var meses_es = ["enero", "febrero", "marzo", "abril", "mayo", "junio", 
				"julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"]

func _ready():
	# Conecta o sinal do Timer via código (mais seguro)
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	atualizar_interface()

func _on_timer_timeout():
	if pausa: return
	
	dia += 1
	if dia > 30: # Simplificação de 30 dias por mês
		dia = 1
		mes += 1
	if mes > 12:
		mes = 1
		ano += 1
	
	atualizar_interface()
	checar_eventos()

func atualizar_interface():
	var data_texto = meses_es[mes-1] + " de " + str(ano)
	print(data_texto) # Por enquanto sai no console
	if label_data: label_data.text = data_texto

func checar_eventos():
	# GATILHO DA INDEPENDÊNCIA: 3 de Noviembre de 1903
	if dia == 3 and mes == 11 and ano == 1903:
		executar_independencia()

func executar_independencia():
	pausa = true
	print("¡Independencia de Panamá!")
	
	# 1. Pegamos a cor do Panamá que está no seu CountryData
	# 'PAN' é a ID que você definiu no seu arquivo de países
	var cor_panama = country_data.country_id_to_color["PAN"]
	
	# 2. Chamamos a função do seu script de render que já existe:
	# 835 é o ID da província. Se tiver mais, repita a linha.
	map_data.update_color_map(835, cor_panama)
	country_data.province_id_to_owner[835] = "PAN"
	map_data.update_color_map(2819, cor_panama)
	country_data.province_id_to_owner[2819] = "PAN"
	map_data.update_color_map(4595, cor_panama)
	country_data.province_id_to_owner[4595] = "PAN"
	map_data.update_color_map(2664, cor_panama)
	country_data.province_id_to_owner[2664] = "PAN"
