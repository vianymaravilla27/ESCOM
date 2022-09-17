#Funciónn Principal del programa
main <- function() {
  cat("Bienvenido\n")
  cat("Calculadora de ahorro por viajes compartidos...\n\n")
  #Registro de viajes.
  viajes <- registrar_viajes()
  #Impresión del los viajes realizados.
  print(viajes)
  View(viajes)
  #Resultado por viajes: costo del viaje, costo por persona y ahorrado.
  resultados_viajes <- obtener_resultados(viajes) 
  print(resultados_viajes)
  View(resultados_viajes)
  #Obtención de resultados diarios.
  calcular_resultados(resultados_viajes)
  #Resultados del día: costo diario, costo diario por persona y ahorrado diario. 
  generar_graficos(viajes, resultados_viajes)
}

registrar_viajes <- function() {
  respuesta <- "Si"
  bandera = TRUE
  cat("Es necesario que ingreses los siguientes datos:\n")
  cat("1. Kilometros conducidos\n")
  cat("2. Costo por litro de gasolina\n")
  cat("3. Kilometros por litro\n")
  cat("4. Peaje\n")
  cat("5. Cuotas por estacionamiento\n")
  cat("6. Número de integrantes por viaje\n\n")
  #Obtención del primer carácter de la respuesta.
  respuesta <- substr(respuesta, start = 1, stop = 1)
  while (respuesta == 'S' || respuesta == 's') {
    #Ingreso de los resultados del usuario.
    #Se realizan algunas validaciones de los datos de entrada.
    cat("1. ¿Cuántos kilometros recorriste?")
    km_recorridos <- as.numeric(readLines(n = 1))
    if (is.na(km_recorridos)) km_recorridos = 0
    cat("2. Ingresa el precio por litro de gasolina")
    costo_lt_gas <- as.numeric(readLines(n = 1))
    #Promedio del costo de gasolina.
    if (is.na(costo_lt_gas)) costo_lt_gas = 20
    cat("3. ¿Cuántos kilometros por litro de gasolina?")
    km_lt <- as.numeric(readLines(n = 1))
    #Promedio de km por litro de gasolina.
    if (is.na(km_lt)) km_lt = 12
    cat("4. ¿Cuánto gastaste en peajes?")
    peaje_recorrido <- as.numeric(readLines(n = 1))
    if (is.na(peaje_recorrido)) peaje_recorrido = 0
    cat("5. ¿Cuánto gastaste en estacionamiento?")
    cuota_estacionamiento <- as.numeric(readLines(n = 1))
    if (is.na(cuota_estacionamiento)) cuota_estacionamiento = 0
    cat("6. ¿Cuántas personas viajaron contigo? (incluyendote)")
    integrantes <- as.numeric(readLines(n = 1))
    if (is.na(integrantes)) integrantes = 1
    cat("\n")
    if (bandera == TRUE) {
      #Creación de la matriz llamada viajes.
      viajes <- matrix(c(km_recorridos, costo_lt_gas, km_lt,
                         peaje_recorrido, cuota_estacionamiento, 
                         integrantes), ncol = 6, byrow = T)
      colnames(viajes) <- c("km_recorridos", "costo_lt_gas", 
                            "km_lt", "peaje_recorrido",
                            "cuota_estacionamiento", "integrantes")
      bandera = FALSE
    } else {
      #Actualización de la matriz llamda viajes.
      viajes <- rbind(viajes, c(km_recorridos, costo_lt_gas, 
                                km_lt, peaje_recorrido, 
                                cuota_estacionamiento, integrantes))
    }
    cat("¿Quieres realizar más viajes?")
    respuesta <- readLines(n = 1)
    cat("\n")
    respuesta <- substr(respuesta, start = 1, stop = 1)
  }
  #Retorno de la matriz viajes.
  return(viajes)
}

obtener_resultados <- function(viajes) {
  bandera = TRUE
  #Obtención de las dimensiones del viaje.
  dim_viajes <- dim(viajes)
  cat("\n")
  for (i in 1:dim_viajes[1]) {
    #Obtención de los resultados obtenidos por viajes.
    litros_necesarios <- viajes[i, "km_recorridos"] / viajes[i, "km_lt"]
    costo_total_gasolina <- litros_necesarios * viajes[i, "costo_lt_gas"]
    costo_total <- costo_total_gasolina + 
      viajes[i, "peaje_recorrido"] + viajes[i, "cuota_estacionamiento"]
    costo_persona <- costo_total / viajes[i, "integrantes"]
    ahorrado <- costo_total - costo_persona 
    #Impresión de los resultados obtenidos por viajes.
    cat("Resultados obtenidos del viaje ", i, "...\n")
    cat("Litros necesarios para tu viaje:   ", litros_necesarios, "\n")
    cat("Costo total de la gasolina:       $", costo_total_gasolina, "\n")
    cat("El costo total del viaje es de:   $", costo_total, "\n")
    cat("El costo por persona:             $", costo_persona, "\n")
    cat("Te ahorraste:                     $", ahorrado, "\n\n")
    if (bandera == TRUE) {
      #Creación de la matriz con los resultados.
      resultados_viajes <- matrix(c(costo_total, costo_persona, ahorrado), 
                                  ncol = 3, byrow = TRUE)
      colnames(resultados_viajes) <- c("costo_total", "costo_persona", 
                                       "ahorrado")
      bandera = FALSE
    } else {
      #Actualización de la matriz con los resultados.
      resultados_viajes <- rbind(resultados_viajes, 
                                 c(costo_total, costo_persona, ahorrado))
    }
  }
  #Retorno del la matriz de resultados.
  return(resultados_viajes)
}

calcular_resultados <- function(resultados_viajes) {
  #Resultados finales.
  res_diarios <- colSums(resultados_viajes)
  cat("\n")
  cat("Costo total diario:       $", res_diarios[1], "\n")
  cat("Costo por persona diario: $", res_diarios[2], "\n")
  cat("Ahorrado diario:          $", res_diarios[3], "\n")
}

generar_graficos <- function(viajes, resultados_viajes) {
  #Generación de gráfico.
  plot(x = viajes[, "integrantes"], y = resultados_viajes[, "ahorrado"], 
       main = "Ahorrado por integrantes", xlab = "Integrantes",
       ylab = "Ahorrado")
}

main()