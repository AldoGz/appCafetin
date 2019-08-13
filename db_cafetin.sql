-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-08-2019 a las 05:13:29
-- Versión del servidor: 10.1.31-MariaDB
-- Versión de PHP: 5.6.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_cafetin`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id` int(11) NOT NULL,
  `nombre` varchar(75) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '1',
  `id_tipo_servicio` int(11) NOT NULL,
  `foto` varchar(255) NOT NULL DEFAULT 'defecto.jpg'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id`, `nombre`, `estado`, `id_tipo_servicio`, `foto`) VALUES
(1, 'EMPANADAS', 1, 2, 'imgCat1.jpg'),
(2, 'SANDWICH', 1, 2, 'imgCat3.jpg'),
(3, 'ENSALADAS', 1, 2, 'imgCat2.jpg'),
(4, 'DESAYUNOS', 1, 2, 'imgCat4.jpg'),
(5, 'BEBIDAS', 1, 1, 'imgCat5.jpg'),
(6, 'TORTAS', 1, 1, 'imgCat7.jpg'),
(7, 'GUARNICIONES', 1, 2, 'defecto.jpg'),
(8, 'CON ALCOHOL', 1, 1, 'defecto.jpg'),
(9, 'CAFE TOSTADO MOLIDO', 1, 1, 'defecto.jpg'),
(10, 'POSTRES', 1, 2, 'defecto.jpg'),
(11, 'GUARNICIONES', 1, 2, 'defecto.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `id` int(11) NOT NULL,
  `dni` char(8) NOT NULL,
  `nombres` varchar(75) NOT NULL,
  `apellido_paterno` varchar(75) NOT NULL,
  `apellido_materno` varchar(75) NOT NULL,
  `sexo` int(11) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `tele_uno` varchar(25) DEFAULT NULL,
  `tele_dos` varchar(25) DEFAULT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` int(11) NOT NULL DEFAULT '1',
  `id_tipo_empleado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`id`, `dni`, `nombres`, `apellido_paterno`, `apellido_materno`, `sexo`, `direccion`, `tele_uno`, `tele_dos`, `fecha_registro`, `estado`, `id_tipo_empleado`) VALUES
(1, 'admin', 'NOEMI', 'ROSILLO', 'PINZON', 1, '', NULL, NULL, '2019-02-15 10:53:36', 1, 1),
(2, 'mesero1', 'CESAR DANIEL', 'ROSILLO', 'PINZON', 1, '', NULL, NULL, '2019-02-15 10:54:20', 1, 2),
(3, 'cajero', 'CONSUELO', 'PINZON', 'MONDRAGON', 0, '', NULL, NULL, '2019-02-15 10:56:05', 1, 3),
(4, 'mesero2', 'CESAR DANIEL', 'ROSILLO', 'PINZON', 1, '', NULL, NULL, '2019-02-22 00:14:26', 0, 2),
(5, 'cocina', 'MANUEL', 'CARBAJAL', 'PEREZ', 1, '', '925749774', NULL, '2019-02-22 00:44:14', 1, 4),
(6, 'bar', 'ROBIS', 'PADRON', '   ', 1, '', NULL, NULL, '2019-02-22 18:51:31', 1, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_proceso`
--

CREATE TABLE `estado_proceso` (
  `id` int(11) NOT NULL,
  `toma_pedido` varchar(100) DEFAULT NULL,
  `pedido` varchar(100) DEFAULT NULL,
  `estado_convencional_mesa` varchar(75) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `estado_proceso`
--

INSERT INTO `estado_proceso` (`id`, `toma_pedido`, `pedido`, `estado_convencional_mesa`) VALUES
(1, 'EN ESPERA', 'CONFIRMAR', 'CARRITO VACIO'),
(2, 'RECOGER PEDIDO PARA MESA', 'FINALIZAR', 'CARRITO LLENO'),
(3, 'ENTREGAR PEDIDO PARA MESA', 'ANULAR', NULL),
(4, 'ANULAR EL PEDIDO', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturacion`
--

CREATE TABLE `facturacion` (
  `id` int(11) NOT NULL,
  `id_pedido` int(11) NOT NULL,
  `id_tipo_comprobante` char(2) NOT NULL,
  `numero` int(11) DEFAULT NULL,
  `correlativo` int(11) DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `documento` varchar(11) DEFAULT NULL,
  `razon_social` varchar(255) DEFAULT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `usuario` varchar(100) NOT NULL,
  `monto` decimal(6,2) NOT NULL,
  `puntos` int(11) NOT NULL,
  `estado_puntos` int(11) NOT NULL DEFAULT '1',
  `monto_descuento` decimal(6,2) NOT NULL,
  `monto_amotizacion` decimal(6,2) NOT NULL,
  `ticket` varchar(32) NOT NULL,
  `producto` varchar(100) NOT NULL,
  `cantidad_producto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `facturacion`
--

INSERT INTO `facturacion` (`id`, `id_pedido`, `id_tipo_comprobante`, `numero`, `correlativo`, `fecha_registro`, `documento`, `razon_social`, `direccion`, `usuario`, `monto`, `puntos`, `estado_puntos`, `monto_descuento`, `monto_amotizacion`, `ticket`, `producto`, `cantidad_producto`) VALUES
(1, 1, '03', 1, 1, '2019-03-17 00:56:23', '', '', '', 'Mesa 4', '16.00', 16, 1, '0.00', '16.00', '', '', 0),
(2, 2, '03', 1, 2, '2019-03-17 01:10:11', '', '', '', 'Jose', '26.00', 26, 1, '0.00', '26.00', '', '', 0),
(3, 3, '03', 1, 3, '2019-03-17 01:23:03', '', '', '', 'Mesa 1', '42.00', 42, 1, '0.00', '42.00', '', '', 0),
(4, 4, '03', 1, 4, '2019-03-17 01:23:57', '', '', '', 'Mesa 6', '35.00', 35, 1, '0.00', '35.00', '', '', 0),
(5, 5, '03', 1, 5, '2019-03-17 02:17:52', '', '', '', 'Rodolfo', '48.00', 48, 1, '0.00', '48.00', '', '', 0),
(6, 6, '03', 1, 6, '2019-03-17 02:22:54', '', '', '', 'Wilmer cadenillas', '50.50', 50, 1, '0.00', '50.50', '', '', 0),
(7, 7, '03', 1, 7, '2019-03-17 02:27:59', '', '', '', 'Brando', '25.50', 25, 1, '0.00', '25.50', '', '', 0),
(8, 8, '03', 1, 8, '2019-03-17 03:18:49', '', '', '', 'Rene', '16.00', 16, 1, '0.00', '16.00', '', '', 0),
(9, 12, '03', 1, 9, '2019-03-17 04:04:46', '', '', '', 'Ronal', '52.00', 52, 1, '0.00', '52.00', '', '', 0),
(10, 15, '03', 1, 10, '2019-03-17 04:05:56', '', '', '', 'Clieny', '12.00', 12, 1, '0.00', '12.00', '', '', 0),
(11, 13, '03', 1, 11, '2019-03-17 04:17:31', '', '', '', 'Santiago', '49.00', 49, 1, '0.00', '49.00', '', '', 0),
(12, 10, '03', 1, 12, '2019-03-17 04:17:48', '', '', '', 'Tereza', '39.50', 39, 1, '0.00', '39.50', '', '', 0),
(13, 9, '03', 1, 13, '2019-03-17 04:17:57', '', '', '', 'Nanci Rivera', '74.00', 74, 1, '0.00', '74.00', '', '', 0),
(14, 14, '03', 1, 14, '2019-03-17 04:27:46', '', '', '', 'Angélica', '98.00', 98, 1, '0.00', '98.00', '', '', 0),
(15, 11, '03', 1, 15, '2019-03-17 04:10:00', '', '', '', 'Es 1', '18.50', 18, 1, '0.00', '18.50', '', '', 0),
(16, 17, '03', 1, 16, '2019-03-17 21:51:35', '', '', '', 'Pulsar 135', '19.50', 19, 1, '0.00', '19.50', '', '', 0),
(17, 16, '03', 1, 17, '2019-03-17 22:06:59', '', '', '', 'USA', '32.50', 32, 1, '0.00', '32.50', '', '', 0),
(18, 18, '03', 1, 18, '2019-03-17 22:25:31', '', '', '', 'Esther Pinzon', '12.00', 12, 1, '0.00', '12.00', '', '', 0),
(19, 19, '03', 1, 19, '2019-03-17 23:40:59', '', '', '', 'Café helado', '23.50', 23, 1, '0.00', '23.50', '', '', 0),
(20, 21, '03', 1, 20, '2019-03-17 23:56:09', '', '', '', 'Tres patas gatos', '18.00', 18, 1, '0.00', '18.00', '', '', 0),
(21, 20, '03', 1, 21, '2019-03-18 01:02:03', '', '', '', 'Sarela', '48.00', 48, 1, '0.00', '48.00', '', '', 0),
(22, 22, '03', 1, 22, '2019-03-18 01:23:34', '', '', '', 'Renzo', '26.00', 26, 1, '0.00', '26.00', '', '', 0),
(23, 23, '03', 1, 23, '2019-03-18 01:31:48', '', '', '', 'Melanie', '34.00', 34, 1, '0.00', '34.00', '', '', 0),
(24, 24, '03', 1, 24, '2019-03-18 02:44:32', '', '', '', 'Manuel quispe', '52.00', 52, 1, '0.00', '52.00', '', '', 0),
(25, 25, '03', 1, 25, '2019-03-18 03:31:54', '', '', '', 'Chica de pantalón azul', '30.00', 30, 1, '0.00', '30.00', '', '', 0),
(26, 26, '03', 1, 26, '2019-03-18 04:01:45', '', '', '', 'Esther Pinzon', '15.00', 15, 1, '0.00', '15.00', '', '', 0),
(27, 16, '03', 1, 27, '2019-03-18 04:01:56', '', '', '', 'USA', '30.00', 30, 1, '0.00', '30.00', '', '', 0),
(28, 27, '03', 1, 28, '2019-03-18 23:05:54', '', '', '', 'Julio', '17.00', 17, 1, '0.00', '17.00', '', '', 0),
(29, 28, '03', 1, 29, '2019-03-19 00:51:30', '', '', '', 'Marciano Requejo', '48.00', 48, 1, '0.00', '48.00', '', '', 0),
(30, 30, '03', 1, 30, '2019-03-19 01:10:22', '', '', '', 'Palo blanco', '53.00', 53, 1, '0.00', '53.00', '', '', 0),
(31, 30, '03', 1, 31, '2019-03-19 02:11:46', '', '', '', 'Palo blanco', '72.50', 72, 1, '0.00', '72.50', '', '', 0),
(32, 29, '03', 1, 32, '2019-03-19 02:53:01', '', '', '', 'Eduar', '23.00', 23, 1, '0.00', '23.00', '', '', 0),
(33, 16, '03', 1, 33, '2019-03-19 03:34:48', '', '', '', 'USA', '20.00', 20, 1, '0.00', '20.00', '', '', 0),
(34, 16, '03', 1, 34, '2019-03-19 04:20:59', '', '', '', 'USA', '16.00', 16, 1, '0.00', '16.00', '', '', 0),
(35, 33, '03', 1, 35, '2019-03-19 04:21:37', '', '', '', 'Esther Pinzón', '23.00', 23, 1, '0.00', '23.00', '', '', 0),
(36, 31, '03', 1, 36, '2019-03-19 04:25:19', '', '', '', 'Reiles', '29.00', 29, 1, '0.00', '29.00', '', '', 0),
(37, 34, '03', 1, 37, '2019-03-19 05:20:23', '', '', '', 'Marciano Requej', '30.00', 30, 1, '0.00', '30.00', '', '', 0),
(38, 35, '01', 1, 1, '2019-03-20 00:37:14', '20487594670', 'INVERSIONES MARDI E.I.R.L.', 'CAL.SACSAYHUAMAN CDRA. 1 NRO. S|N SECTOR PUEBLO LIBRE CAJAMARCA - JAEN - JAEN', 'Primeros', '12.50', 12, 1, '0.00', '12.50', '', '', 0),
(40, 32, '01', 1, 2, '2019-03-20 01:37:57', '20480014678', 'COOPERATIVA DE AHORRO Y CREDITO NORANDINO LTDA', 'CAL.PARDO MIGUEL NRO. 417 (3 CUADRAS DE PLAZA DE ARMAS) CAJAMARCA - JAEN - JAEN', 'Es1', '83.00', 83, 1, '0.00', '83.00', '', '', 0),
(42, 38, '03', 1, 39, '2019-03-20 01:40:09', '', '', '', 'Gsggs', '16.00', 16, 1, '0.00', '16.00', '', '', 0),
(43, 40, '03', 1, 40, '2019-03-20 02:14:45', '', '', '', 'Señor canoso', '41.00', 41, 1, '0.00', '41.00', '', '', 0),
(44, 37, '03', 1, 41, '2019-03-20 02:17:30', '', '', '', 'Luis ángel', '80.00', 80, 1, '0.00', '80.00', '', '', 0),
(45, 42, '03', 1, 42, '2019-03-20 03:05:31', '', '', '', 'Mesa cuatro', '17.00', 17, 1, '0.00', '17.00', '', '', 0),
(46, 41, '03', 1, 43, '2019-03-20 03:30:17', '', '', '', 'Marciano requejo', '82.00', 82, 1, '0.00', '82.00', '', '', 0),
(48, 39, '03', 1, 44, '2019-03-20 03:39:00', '', '', '', 'Cristián', '27.00', 27, 1, '0.00', '27.00', '', '', 0),
(49, 43, '03', 1, 45, '2019-03-20 03:46:39', '', '', '', 'Nayla', '34.00', 34, 1, '0.00', '34.00', '', '', 0),
(50, 36, '03', 1, 46, '2019-03-20 03:48:17', '', '', '', 'Señorara', '44.00', 44, 1, '0.00', '44.00', '', '', 0),
(51, 46, '03', 1, 47, '2019-03-20 04:28:54', '', '', '', 'Mesa 6', '41.00', 41, 1, '0.00', '41.00', '', '', 0),
(52, 47, '03', 1, 48, '2019-03-20 14:52:25', '', '', '', 'Fernando', '7.00', 7, 1, '0.00', '7.00', '', '', 0),
(53, 48, '03', 1, 49, '2019-03-20 15:21:04', '', '', '', 'Jorge Rodriguez', '16.00', 16, 1, '0.00', '16.00', '', '', 0),
(54, 49, '03', 1, 50, '2019-03-20 15:33:38', '', '', '', 'Carlos castro', '30.00', 30, 1, '0.00', '30.00', '', '', 0),
(55, 50, '03', 1, 51, '2019-03-20 17:12:20', '', '', '', 'Jorge luis', '28.00', 28, 1, '0.00', '28.00', '', '', 0),
(56, 51, '03', 1, 52, '2019-03-20 18:28:06', '', '', '', 'Representaciones Mego', '21.00', 21, 1, '0.00', '21.00', '', '', 0),
(57, 55, '03', 1, 53, '2019-03-20 23:41:32', '', '', '', 'Amigo de Gucci', '15.00', 15, 1, '0.00', '15.00', '', '', 0),
(58, 53, '03', 1, 54, '2019-03-21 00:09:06', '', '', '', 'Luis', '32.00', 32, 1, '0.00', '32.00', '', '', 0),
(59, 54, '03', 1, 55, '2019-03-21 00:15:28', '', '', '', 'Karelly ', '35.00', 35, 1, '0.00', '35.00', '', '', 0),
(60, 56, '03', 1, 56, '2019-03-21 00:15:52', '', '', '', 'Oro', '18.00', 18, 1, '0.00', '18.00', '', '', 0),
(61, 52, '03', 1, 57, '2019-03-21 00:48:56', '', '', '', 'Sai', '28.00', 28, 1, '0.00', '28.00', '', '', 0),
(62, 57, '03', 1, 58, '2019-03-21 01:01:07', '', '', '', 'Uhu', '26.00', 26, 1, '0.00', '26.00', '', '', 0),
(63, 58, '03', 1, 59, '2019-03-21 01:09:59', '', '', '', 'Militza', '32.00', 32, 1, '0.00', '32.00', '', '', 0),
(64, 60, '03', 1, 60, '2019-03-21 01:16:41', '', '', '', 'Gustavo', '5.00', 5, 1, '0.00', '5.00', '', '', 0),
(65, 62, '03', 1, 61, '2019-03-21 02:11:36', '', '', '', 'Diana diaz', '22.00', 22, 1, '0.00', '22.00', '', '', 0),
(66, 61, '03', 1, 62, '2019-03-21 02:38:31', '', '', '', 'Rony', '25.50', 25, 1, '0.00', '25.50', '', '', 0),
(67, 63, '03', 1, 63, '2019-03-21 03:18:07', '', '', '', 'Lederson', '11.50', 11, 1, '0.00', '11.50', '', '', 0),
(68, 59, '03', 1, 64, '2019-03-21 03:21:56', '', '', '', 'Novio de Mili', '24.00', 24, 1, '0.00', '24.00', '', '', 0),
(69, 66, '03', 1, 65, '2019-03-21 03:27:23', '', '', '', 'Roger Guevara', '24.00', 24, 1, '0.00', '24.00', '', '', 0),
(70, 67, '03', 1, 66, '2019-03-21 03:31:00', '', '', '', 'Neyser', '13.00', 13, 1, '0.00', '13.00', '', '', 0),
(71, 64, '03', 1, 67, '2019-03-21 03:35:05', '', '', '', 'Rasa Cubas', '10.00', 10, 1, '0.00', '10.00', '', '', 0),
(72, 68, '03', 1, 68, '2019-03-21 04:24:16', '', '', '', 'Kati Mesones', '24.00', 24, 1, '0.00', '24.00', '', '', 0),
(73, 69, '03', 1, 69, '2019-03-21 04:24:53', '', '', '', 'Noemi', '30.00', 30, 1, '0.00', '30.00', '', '', 0),
(74, 71, '03', 1, 70, '2019-03-22 00:21:50', '', '', '', 'Jhordan', '27.00', 27, 1, '0.00', '27.00', '', '', 0),
(75, 72, '03', 1, 71, '2019-03-22 00:55:38', '', '', '', 'Jose', '21.00', 21, 1, '0.00', '21.00', '', '', 0),
(76, 73, '03', 1, 72, '2019-03-22 00:56:57', '', '', '', 'Lisandro', '26.00', 26, 1, '0.00', '26.00', '', '', 0),
(77, 74, '03', 1, 73, '2019-03-22 01:26:00', '', '', '', 'Jhymi mio', '39.00', 39, 1, '0.00', '39.00', '', '', 0),
(78, 75, '03', 1, 74, '2019-03-22 01:29:13', '', '', '', 'Gustavo Rosillo', '13.00', 13, 1, '0.00', '13.00', '', '', 0),
(79, 76, '03', 1, 75, '2019-03-22 02:42:18', '', '', '', 'Ricardo villafuerte', '21.50', 21, 1, '0.00', '21.50', '', '', 0),
(80, 79, '03', 1, 76, '2019-03-22 03:07:50', '', '', '', 'Niña', '10.00', 10, 1, '0.00', '10.00', '', '', 0),
(81, 83, '03', 1, 77, '2019-03-22 03:47:27', '', '', '', 'Ronal ', '19.50', 19, 1, '0.00', '19.50', '', '', 0),
(82, 81, '03', 1, 78, '2019-03-22 03:53:38', '', '', '', 'Abigail', '24.00', 24, 1, '0.00', '24.00', '', '', 0),
(83, 82, '03', 1, 79, '2019-03-22 04:14:14', '', '', '', 'Bances', '16.50', 16, 1, '0.00', '16.50', '', '', 0),
(84, 80, '03', 1, 80, '2019-03-22 05:21:53', '', '', '', 'Candy', '37.50', 37, 1, '0.00', '37.50', '', '', 0),
(85, 84, '03', 1, 81, '2019-03-22 05:38:52', '', '', '', 'Alex Cubas', '31.50', 31, 1, '0.00', '31.50', '', '', 0),
(86, 86, '03', 1, 82, '2019-03-22 13:49:37', '', '', '', 'Tomas Rosales', '34.00', 34, 1, '0.00', '34.00', '', '', 0),
(87, 85, '03', 1, 83, '2019-03-22 14:42:45', '', '', '', 'Rene', '45.00', 45, 1, '0.00', '45.00', 'Noemí', '', 0),
(88, 88, '03', 1, 84, '2019-03-22 22:12:12', '', '', '', 'Señor', '25.50', 25, 1, '0.00', '25.50', '', '', 0),
(89, 87, '03', 1, 85, '2019-03-22 22:14:54', '', '', '', 'Señor', '16.00', 16, 1, '0.00', '16.00', '', '', 0),
(90, 90, '03', 1, 86, '2019-03-22 22:15:06', '', '', '', 'Representaciones Mego', '25.00', 25, 1, '0.00', '25.00', '', '', 0),
(91, 91, '03', 1, 87, '2019-03-22 22:55:32', '', '', '', 'Treice', '35.00', 35, 1, '0.00', '35.00', '', '', 0),
(92, 92, '03', 1, 88, '2019-03-22 23:52:19', '', '', '', 'Silvia', '40.00', 40, 1, '0.00', '40.00', '', '', 0),
(93, 94, '03', 1, 89, '2019-03-23 01:01:24', '', '', '', 'Señor', '16.00', 16, 1, '0.00', '16.00', '', '', 0),
(94, 93, '01', 1, 3, '2019-03-23 01:15:50', '20480171188', 'DIAVELL S.A.C.', 'CAL.LAS BEGONIAS NRO. 134 LAS FLORES (A MEDIA CDRA REST. LAS TOTORITAS) CAJAMARCA - JAEN - JAEN', 'Señor', '96.00', 96, 1, '0.00', '96.00', '', '', 0),
(95, 89, '03', 1, 90, '2019-03-23 01:26:37', '', '', '', 'Chico de lentes', '24.00', 24, 1, '0.00', '24.00', '', '', 0),
(96, 99, '03', 1, 91, '2019-03-23 01:57:01', '', '', '', 'Demetrio', '15.50', 15, 1, '0.00', '15.50', '', '', 0),
(97, 95, '03', 1, 92, '2019-03-23 02:19:01', '', '', '', 'Sara Rioja', '101.50', 101, 1, '0.00', '101.50', '', '', 0),
(98, 101, '03', 1, 93, '2019-03-23 02:39:59', '', '', '', 'Esspresso', '11.00', 11, 1, '0.00', '11.00', '', '', 0),
(99, 98, '03', 1, 94, '2019-03-23 12:41:22', '', '', '', 'Norbil ', '56.50', 56, 1, '0.00', '56.50', '', '', 0),
(100, 102, '03', 1, 95, '2019-03-23 12:41:31', '', '', '', 'Señor', '10.00', 10, 1, '0.00', '10.00', '', '', 0),
(101, 95, '03', 1, 96, '2019-03-23 12:41:38', '', '', '', 'Sara Rioja', '20.00', 20, 1, '0.00', '20.00', '', '', 0),
(102, 97, '03', 1, 97, '2019-03-23 12:41:49', '', '', '', 'Señorita', '8.50', 8, 1, '0.00', '8.50', '', '', 0),
(103, 103, '03', 1, 98, '2019-03-23 12:47:20', '', '', '', 'Para llevar', '18.00', 18, 1, '0.00', '18.00', '', '', 0),
(108, 105, '03', 1, 101, '2019-03-24 21:46:33', '', '', '', 'NJ', '76.00', 76, 1, '0.00', '76.00', '', '', 0),
(109, 106, '03', 1, 102, '2019-03-24 21:51:36', '', '', '', 'KI', '61.50', 61, 1, '0.00', '61.50', '', '', 0),
(110, 107, '03', 1, 103, '2019-03-24 23:14:31', '', '', '', 'prueba1', '11.00', 11, 1, '0.00', '11.00', '', '', 0),
(111, 109, '01', 1, 4, '2019-03-30 21:53:22', '10098685061', 'CARDENAS FONSECA JAIME', 'SIN DOMICILIO FISCAL', 'prueba3', '12.00', 12, 1, '0.00', '12.00', '', '', 0),
(112, 117, '03', 1, 104, '2019-04-01 22:41:14', '', '', '', '8888', '3.00', 3, 1, '0.00', '3.00', '', '', 0),
(113, 113, '03', 1, 105, '2019-04-01 22:41:23', '', '', '', 'pamta', '15.00', 15, 1, '0.00', '15.00', '', '', 0),
(114, 108, '03', 1, 106, '2019-04-01 22:41:39', '', '', '', 'prueba2', '15.00', 15, 1, '0.00', '15.00', '', '', 0),
(115, 114, '03', 1, 107, '2019-04-01 22:41:51', '', '', '', 'ROSEMERI', '9.00', 9, 1, '0.00', '9.00', '', '', 0),
(116, 110, '03', 1, 108, '2019-04-01 22:41:59', '', '', '', 'prueba5', '4.50', 4, 1, '0.00', '4.50', '', '', 0),
(117, 111, '03', 1, 109, '2019-04-01 22:42:08', '', '', '', 'prueba6', '10.50', 10, 1, '0.00', '10.50', '', '', 0),
(118, 112, '03', 1, 110, '2019-04-01 22:42:15', '', '', '', 'APA', '18.00', 18, 1, '0.00', '18.00', '', '', 0),
(119, 115, '03', 1, 111, '2019-04-01 22:42:21', '', '', '', 'TRO', '19.50', 19, 1, '0.00', '19.50', '', '', 0),
(120, 116, '03', 1, 112, '2019-04-01 22:42:29', '', '', '', '999', '3.00', 3, 1, '0.00', '3.00', '', '', 0),
(121, 118, '03', 1, 113, '2019-04-01 22:42:35', '', '', '', '555', '3.00', 3, 1, '0.00', '3.00', '', '', 0),
(122, 124, '03', 1, 114, '2019-05-15 17:53:27', '', '', '', 'xO', '24.00', 24, 1, '0.00', '24.00', '', '', 0),
(123, 125, '03', 1, 115, '2019-05-15 17:56:09', '', '', '', 'tr', '11.00', 11, 1, '0.00', '11.00', '', '', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mesa`
--

CREATE TABLE `mesa` (
  `id` int(11) NOT NULL,
  `numero` varchar(100) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '1',
  `estado_convencional` int(11) NOT NULL DEFAULT '1',
  `disponibilidad` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `mesa`
--

INSERT INTO `mesa` (`id`, `numero`, `estado`, `estado_convencional`, `disponibilidad`) VALUES
(1, 'Barra 1', 1, 1, 0),
(2, 'Barra 2', 1, 1, 0),
(3, 'Barra 3', 1, 1, 0),
(4, 'Barra 4', 1, 1, 0),
(5, 'Mesa 1', 1, 1, 0),
(6, 'Mesa 2', 1, 1, 0),
(7, 'Mesa 3', 1, 1, 0),
(8, 'Mesa 4', 1, 1, 0),
(9, 'Mesa 5', 1, 1, 0),
(10, 'Mesa 6', 1, 1, 0),
(11, 'Banco 1', 1, 1, 0),
(12, 'Banco 2', 1, 1, 0),
(13, 'Banco 3', 1, 1, 0),
(14, 'Banco 4', 1, 1, 0),
(15, 'Banco 5', 1, 1, 0),
(16, 'Banco 6', 1, 1, 0),
(17, 'Banco 7', 1, 1, 0),
(18, 'Banco 8', 1, 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

CREATE TABLE `pedido` (
  `id` int(11) NOT NULL,
  `id_mesa` int(11) NOT NULL,
  `id_empleado` int(11) NOT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` int(11) NOT NULL DEFAULT '1',
  `nombre_cliente` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `pedido`
--

INSERT INTO `pedido` (`id`, `id_mesa`, `id_empleado`, `fecha_registro`, `estado`, `nombre_cliente`) VALUES
(1, 4, 2, '2019-03-16 18:14:34', 2, 'Mesa 4'),
(2, 6, 2, '2019-03-16 19:36:48', 2, 'Jose'),
(3, 5, 2, '2019-03-16 19:52:37', 2, 'Mesa 1'),
(4, 16, 2, '2019-03-16 19:59:56', 2, 'Mesa 6'),
(5, 6, 2, '2019-03-16 20:26:06', 2, 'Rodolfo'),
(6, 9, 2, '2019-03-16 20:38:02', 2, 'Wilmer cadenillas'),
(7, 10, 2, '2019-03-16 20:56:35', 2, 'Brando'),
(8, 7, 2, '2019-03-16 21:03:28', 2, 'Rene'),
(9, 10, 2, '2019-03-16 21:34:22', 2, 'Nanci Rivera'),
(10, 9, 2, '2019-03-16 21:46:33', 2, 'Tereza'),
(11, 5, 2, '2019-03-16 21:51:05', 2, 'Es 1'),
(12, 6, 2, '2019-03-16 21:58:25', 2, 'Ronal'),
(13, 8, 2, '2019-03-16 22:02:22', 2, 'Santiago'),
(14, 7, 2, '2019-03-16 22:30:46', 2, 'Angélica'),
(15, 1, 2, '2019-03-16 23:00:32', 2, 'Clieny'),
(16, 5, 2, '2019-03-17 15:58:09', 2, 'USA'),
(17, 11, 2, '2019-03-17 16:28:43', 2, 'Pulsar 135'),
(18, 1, 2, '2019-03-17 16:29:49', 2, 'Esther Pinzon'),
(19, 10, 2, '2019-03-17 16:57:01', 2, 'Café helado'),
(20, 6, 2, '2019-03-17 17:52:51', 2, 'Sarela'),
(21, 5, 2, '2019-03-17 18:27:42', 2, 'Tres patas gatos'),
(22, 7, 2, '2019-03-17 19:45:56', 2, 'Renzo'),
(23, 10, 2, '2019-03-17 19:49:28', 2, 'Melanie'),
(24, 10, 2, '2019-03-17 21:12:54', 2, 'Manuel quispe'),
(25, 9, 2, '2019-03-17 21:26:39', 2, 'Chica de pantalón azul'),
(26, 1, 2, '2019-03-17 21:38:31', 2, 'Esther pinzón'),
(27, 10, 2, '2019-03-18 17:37:13', 2, 'Julio'),
(28, 2, 2, '2019-03-18 17:49:38', 2, 'Marciano Requejo'),
(29, 10, 2, '2019-03-18 19:26:48', 2, 'Eduar'),
(30, 6, 2, '2019-03-18 19:28:19', 2, 'Palo blanco'),
(31, 10, 2, '2019-03-18 21:53:38', 2, 'Reiles'),
(32, 5, 2, '2019-03-18 22:49:23', 2, 'Es1'),
(33, 3, 2, '2019-03-18 23:17:28', 2, 'Esther Pinzón'),
(34, 6, 2, '2019-03-19 00:19:15', 2, 'Marciano Requej'),
(35, 10, 2, '2019-03-19 19:18:53', 2, 'Primeros'),
(36, 8, 2, '2019-03-19 19:35:37', 2, 'Señorara'),
(37, 18, 2, '2019-03-19 20:04:07', 2, 'Luis ángel'),
(38, 9, 2, '2019-03-19 20:07:58', 2, 'Gsggs'),
(39, 7, 2, '2019-03-19 20:22:20', 2, 'Cristián'),
(40, 10, 2, '2019-03-19 20:25:15', 2, 'Señor canoso'),
(41, 9, 2, '2019-03-19 21:09:04', 2, 'Marciano requejo'),
(42, 11, 2, '2019-03-19 21:10:34', 2, 'Mesa cuatro'),
(43, 12, 2, '2019-03-19 21:13:38', 2, 'Nayla'),
(44, 2, 2, '2019-03-19 21:47:55', 2, 'Gustavo'),
(45, 3, 2, '2019-03-19 21:48:38', 2, 'Gus 1'),
(46, 10, 2, '2019-03-19 22:36:13', 2, 'Mesa 6'),
(47, 10, 2, '2019-03-20 09:21:15', 2, 'Fernando'),
(48, 4, 2, '2019-03-20 10:03:39', 2, 'Jorge Rodriguez'),
(49, 2, 2, '2019-03-20 10:09:08', 2, 'Carlos castro'),
(50, 10, 2, '2019-03-20 11:52:21', 2, 'Jorge luis'),
(51, 10, 2, '2019-03-20 12:19:50', 2, 'Representaciones Mego'),
(52, 9, 2, '2019-03-20 17:59:14', 2, 'Sai'),
(53, 10, 2, '2019-03-20 18:21:15', 2, 'Luis'),
(54, 5, 2, '2019-03-20 18:29:06', 2, 'Karelly '),
(55, 2, 2, '2019-03-20 18:33:22', 2, 'Amigo de Gucci'),
(56, 6, 2, '2019-03-20 18:47:27', 2, 'Oro'),
(57, 10, 2, '2019-03-20 19:26:43', 2, 'Uhu'),
(58, 5, 2, '2019-03-20 19:35:36', 2, 'Militza'),
(59, 9, 2, '2019-03-20 20:01:26', 2, 'Novio de Mili'),
(60, 4, 2, '2019-03-20 20:13:25', 2, 'Gustavo'),
(61, 5, 2, '2019-03-20 20:44:39', 2, 'Rony'),
(62, 10, 2, '2019-03-20 20:46:15', 2, 'Diana diaz'),
(63, 15, 2, '2019-03-20 21:04:15', 2, 'Lederson'),
(64, 10, 2, '2019-03-20 21:35:41', 2, 'Rasa Cubas'),
(65, 6, 2, '2019-03-20 21:37:58', 2, 'Norvil'),
(66, 5, 2, '2019-03-20 21:54:55', 2, 'Roger Guevara'),
(67, 8, 2, '2019-03-20 22:06:50', 2, 'Neyser'),
(68, 3, 2, '2019-03-20 22:57:26', 2, 'Kati Mesones'),
(69, 4, 2, '2019-03-20 23:13:53', 2, 'Noemi'),
(70, 6, 2, '2019-03-21 09:30:03', 2, 'Robis'),
(71, 6, 2, '2019-03-21 18:40:22', 2, 'Jhordan'),
(72, 10, 2, '2019-03-21 19:13:16', 2, 'Jose'),
(73, 8, 2, '2019-03-21 19:23:07', 2, 'Lisandro'),
(74, 18, 2, '2019-03-21 19:27:49', 2, 'Jhymi mio'),
(75, 17, 2, '2019-03-21 20:01:20', 2, 'Gustavo Rosillo'),
(76, 10, 2, '2019-03-21 21:05:25', 2, 'Ricardo villafuerte'),
(77, 18, 2, '2019-03-21 21:19:23', 2, 'Amiga de gus'),
(78, 1, 2, '2019-03-21 21:55:05', 2, 'Niña'),
(79, 1, 2, '2019-03-21 22:01:16', 2, 'Niña'),
(80, 5, 2, '2019-03-21 22:10:11', 2, 'Candy'),
(81, 8, 2, '2019-03-21 22:13:26', 2, 'Abigail'),
(82, 10, 2, '2019-03-21 22:15:32', 2, 'Bances'),
(83, 9, 2, '2019-03-21 22:17:40', 2, 'Ronal '),
(84, 9, 2, '2019-03-21 23:17:33', 2, 'Alex Cubas'),
(85, 9, 2, '2019-03-22 08:07:45', 2, 'Rene'),
(86, 5, 2, '2019-03-22 08:10:39', 2, 'Tomas Rosales'),
(87, 9, 2, '2019-03-22 12:08:57', 2, 'Señor'),
(88, 6, 2, '2019-03-22 12:10:54', 2, 'Señor'),
(89, 5, 2, '2019-03-22 12:14:20', 2, 'Chico de lentes'),
(90, 1, 2, '2019-03-22 12:14:56', 2, 'Representaciones Mego'),
(91, 11, 2, '2019-03-22 17:14:15', 2, 'Treice'),
(92, 10, 2, '2019-03-22 17:37:20', 2, 'Silvia'),
(93, 9, 2, '2019-03-22 18:14:16', 2, 'Señor'),
(94, 1, 2, '2019-03-22 19:43:33', 2, 'Señor'),
(95, 10, 2, '2019-03-22 20:00:03', 2, 'Sara Rioja'),
(96, 10, 2, '2019-03-22 20:00:05', 2, 'Sara Rioja'),
(97, 17, 2, '2019-03-22 20:15:33', 2, 'Señorita'),
(98, 6, 2, '2019-03-22 20:25:14', 2, 'Norbil '),
(99, 5, 2, '2019-03-22 20:40:12', 2, 'Demetrio'),
(100, 10, 2, '2019-03-22 20:49:17', 2, 'Sara Rioja'),
(101, 5, 2, '2019-03-22 21:07:22', 2, 'Esspresso'),
(102, 8, 2, '2019-03-22 21:41:23', 2, 'Señor'),
(103, 2, 2, '2019-03-23 07:46:31', 2, 'Para llevar'),
(104, 1, 2, '2019-03-24 15:54:05', 2, 'NIÑA3'),
(105, 10, 2, '2019-03-24 15:55:16', 2, 'NJ'),
(106, 10, 2, '2019-03-24 16:48:19', 2, 'KI'),
(107, 1, 2, '2019-03-24 16:56:14', 2, 'prueba1'),
(108, 2, 2, '2019-03-24 16:56:26', 2, 'prueba2'),
(109, 3, 2, '2019-03-24 16:56:39', 2, 'prueba3'),
(110, 4, 2, '2019-03-24 16:56:51', 2, 'prueba5'),
(111, 5, 2, '2019-03-24 16:57:02', 2, 'prueba6'),
(112, 6, 2, '2019-03-30 16:49:33', 2, 'APA'),
(113, 1, 2, '2019-04-01 16:35:17', 2, 'pamta'),
(114, 3, 2, '2019-04-01 16:37:58', 2, 'ROSEMERI'),
(115, 8, 2, '2019-04-01 16:39:12', 2, 'TRO'),
(116, 15, 2, '2019-04-01 17:09:22', 2, '999'),
(117, 18, 2, '2019-04-01 17:09:50', 2, '8888'),
(118, 17, 2, '2019-04-01 17:10:17', 2, '555'),
(119, 1, 2, '2019-04-01 17:49:27', 2, 'ivan'),
(120, 2, 2, '2019-04-01 17:51:30', 2, 'dalia'),
(121, 3, 2, '2019-04-03 02:41:57', 2, 'media'),
(122, 4, 2, '2019-04-03 02:42:53', 2, 'media'),
(123, 5, 2, '2019-05-08 10:20:26', 2, 'asx'),
(124, 11, 2, '2019-05-15 12:49:49', 2, 'xO'),
(125, 11, 2, '2019-05-15 12:55:25', 2, 'tr'),
(126, 6, 2, '2019-08-09 20:29:02', 2, 'guido'),
(127, 18, 2, '2019-08-10 09:30:15', 2, 'guido'),
(128, 17, 2, '2019-08-10 11:09:49', 2, 'what'),
(129, 16, 2, '2019-08-10 22:49:30', 2, 'rrr'),
(130, 1, 2, '2019-08-10 23:40:22', 2, 'juan'),
(131, 2, 2, '2019-08-11 18:29:20', 2, 'nuevo'),
(132, 1, 2, '2019-08-11 18:54:22', 2, 'uevo'),
(133, 1, 2, '2019-08-11 19:42:43', 2, 'arturo'),
(134, 1, 2, '2019-08-11 19:51:50', 2, 'uevo'),
(135, 1, 2, '2019-08-11 20:26:00', 2, 'jjj'),
(136, 2, 2, '2019-08-11 21:33:21', 2, 'prueb1'),
(137, 3, 2, '2019-08-11 21:33:31', 2, 'es'),
(138, 5, 2, '2019-08-11 21:44:51', 2, 'ejemplo'),
(139, 5, 2, '2019-08-11 21:50:26', 2, 'asd'),
(140, 11, 2, '2019-08-11 21:54:35', 2, 'ssad'),
(141, 5, 2, '2019-08-12 10:01:07', 2, 'ass'),
(142, 1, 2, '2019-08-12 10:02:25', 2, 'as'),
(143, 5, 2, '2019-08-12 10:03:27', 2, 'aa'),
(144, 1, 2, '2019-08-12 10:15:45', 2, 'aa'),
(145, 5, 2, '2019-08-12 11:13:56', 2, 'aa'),
(146, 1, 2, '2019-08-12 11:26:37', 2, 'a'),
(147, 5, 2, '2019-08-12 11:28:02', 2, 'a'),
(148, 4, 2, '2019-08-12 11:35:03', 2, 'an'),
(149, 8, 2, '2019-08-12 11:35:17', 2, 'a'),
(150, 6, 2, '2019-08-12 11:39:41', 2, 'ass'),
(151, 4, 2, '2019-08-12 11:52:25', 2, 'aa'),
(152, 2, 2, '2019-08-12 11:53:30', 2, 'll'),
(153, 1, 2, '2019-08-12 12:02:40', 2, 'dd');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id` int(11) NOT NULL,
  `nombre` varchar(75) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `descripcion` text NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '1',
  `id_categoria` int(11) NOT NULL,
  `foto` varchar(255) NOT NULL DEFAULT 'defecto.jpg'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id`, `nombre`, `precio`, `descripcion`, `estado`, `id_categoria`, `foto`) VALUES
(1, 'EMPANADA DE CARNE', '8.00', 'Empanada a base de lomo fino al Jugo.', 1, 1, 'defecto.jpg'),
(2, 'EMPANADA DE QUESO', '8.00', 'Empanada a base de de 3 quesos: Queso Blanco, Queso Suizo y Queso Mozarella.', 1, 1, 'defecto.jpg'),
(3, 'ENSALADA CLASICA PERS.', '4.00', '   ', 1, 3, 'defecto.jpg'),
(4, 'ENSALADA CLASICA MED.', '7.00', '', 1, 3, 'defecto.jpg'),
(5, 'ENSALADA ESPECIAL PALTA', '6.00', ' ', 0, 3, 'defecto.jpg'),
(6, 'POLLO CON DURAZNO', '6.00', ' ', 1, 2, 'defecto.jpg'),
(7, 'SANDWICH DE CHICHARRON DE CHANCHO', '8.00', '  ', 1, 2, 'defecto.jpg'),
(8, 'PAVO', '6.00', ' ', 1, 2, 'defecto.jpg'),
(9, 'QUESO BLANCO', '3.50', '  ', 1, 2, 'defecto.jpg'),
(10, 'GALLINA MECHADA', '15.00', ' ', 1, 4, 'defecto.jpg'),
(11, 'CHICHARRON DE CERDO', '15.00', '', 1, 4, 'defecto.jpg'),
(12, 'CAFÉ ESPRESSO ', '3.00', '    ', 1, 5, 'defecto.jpg'),
(13, 'CAFÉ ESPRESSO DOBLE', '3.00', '   ', 1, 5, 'defecto.jpg'),
(14, 'CAFÉ RISTRETTO', '3.00', '  ', 1, 5, 'defecto.jpg'),
(15, 'CAFÉ AMERICANO', '3.50', '', 1, 5, 'defecto.jpg'),
(16, 'CAFÉ PERUANDINO TRADICIÓN', '4.00', '', 1, 5, 'defecto.jpg'),
(17, 'CAFÉ GOTA A GOTA', '5.00', '', 1, 5, 'defecto.jpg'),
(18, 'CAFÉ PRENSA FRANCESA', '6.00', '', 1, 5, 'defecto.jpg'),
(19, 'CAFÉ V60', '8.00', '', 1, 5, 'defecto.jpg'),
(20, 'CAFÉ CAPUCCINO', '5.00', '', 1, 5, 'defecto.jpg'),
(21, 'FRAPPE ANDINO', '12.00', '', 1, 5, 'defecto.jpg'),
(22, 'FRAPPE CLÁSICO', '8.00', '', 1, 5, 'defecto.jpg'),
(23, 'FRAPPE OREO', '8.00', '', 1, 5, 'defecto.jpg'),
(24, 'FRAPPE MANGO', '8.00', '', 1, 5, 'defecto.jpg'),
(25, 'FRAPPE FRESA', '8.00', '', 0, 5, 'defecto.jpg'),
(26, 'FRAPPE LUCUMA', '8.00', '', 1, 5, 'defecto.jpg'),
(27, 'FRAPPE NARANJILLA', '8.00', '', 1, 5, 'defecto.jpg'),
(28, 'PERUANDINO REFRESCANTE', '9.00', '', 1, 5, 'defecto.jpg'),
(29, 'CHOCOLATE', '3.50', '   ', 1, 5, 'defecto.jpg'),
(30, 'QUEQUE CLÁSICO', '2.00', '', 0, 6, 'defecto.jpg'),
(31, 'QUEQUE ESPECIAL', '5.00', '   ', 1, 6, 'defecto.jpg'),
(33, 'AGUA DE PEPINILLO', '2.50', 'Receta de tradición Esther Pinzón', 1, 5, 'defecto.jpg'),
(34, 'CHIVATO', '2.00', '    ', 1, 7, 'defecto.jpg'),
(35, 'COCKTAIL DE ALGARROBINA', '12.00', '  ', 1, 8, 'defecto.jpg'),
(36, 'PISCO SOUR', '10.00', '   ', 1, 8, 'defecto.jpg'),
(37, 'CHILCANO', '10.00', '    ', 1, 8, 'defecto.jpg'),
(38, 'SHOT DE AGUARDIENTE', '6.00', '    ', 1, 8, 'defecto.jpg'),
(39, 'CAFÉ TOSTADO MOLIDO TRADICIONAL 250 GR', '15.00', ' DE 83 PUNTOS EN TAZA- DULCE A FRUTOS DE CAFETO, MELASA DE CAÑA DE AZUCAR, SUAVE ACIDEZ, CUERPO MODERADO, ', 1, 9, 'defecto.jpg'),
(40, 'CAFE TOSTADO MOLIDOTRADICIONAL 500 GR', '26.00', '  SUAVE ACIDEZ, DULCE DE CAÑA , CUERPO MEDIO, CON POS GUSTO PROLONGADO', 1, 9, 'defecto.jpg'),
(41, 'PANQUEQUE CLASICO DE MANJAR', '3.50', ' ', 1, 10, 'defecto.jpg'),
(42, 'PANQUEQUE ESPECIAL DE FRUTAS', '7.00', 'Manjar, Chocolate, Helado, Frutas de la estación.', 1, 10, 'defecto.jpg'),
(43, 'QUEQUE ESPECIAL DE PECANAS', '5.00', ' ', 0, 6, 'defecto.jpg'),
(44, 'HUMITAS', '2.50', ' ', 1, 7, 'defecto.jpg'),
(45, 'ALFAJORES ', '1.00', '5 undidades pequeñitas', 1, 6, 'defecto.jpg'),
(46, 'FRAPPE DE CHOCOLATE', '8.00', 'CHOCOLATE DE TAZA', 1, 5, 'defecto.jpg'),
(47, 'CHOCOPUCCHINO', '5.00', 'CHOCOLATE CON LECHE EMULSIONADA', 1, 5, 'defecto.jpg'),
(48, 'QUESILLO CON MIEL', '5.00', ' ', 1, 10, 'defecto.jpg'),
(49, 'SANDWICH DE CERDO ', '8.00', 'Con mayonesa y/o sarsa', 1, 2, 'defecto.jpg'),
(50, 'QUESILLO COM MIEL', '5.00', '   ', 0, 10, 'defecto.jpg'),
(51, 'SOPA DE PAICO', '10.00', '   ', 1, 4, 'defecto.jpg'),
(52, 'QUEQUE SIMPLE', '2.00', '   ', 1, 4, 'defecto.jpg'),
(53, 'MOJITO', '12.00', 'Ron\r\nHierba buena\r\nHielo\r\nToque de la casa', 1, 8, 'imgPro1.jpg'),
(54, 'MOJITO', '12.00', 'Ron\r\nHierba buena\r\nHielo\r\nToque de la casa', 0, 8, 'imgPro2.jpg'),
(55, 'MOJITO', '12.00', 'Ron', 0, 8, 'defecto.jpg'),
(56, 'POSTRE DEL DíA', '5.00', 'Leche asada', 1, 10, 'defecto.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `promocion_bonus`
--

CREATE TABLE `promocion_bonus` (
  `id` int(11) NOT NULL,
  `ticket` varchar(32) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `porcentaje` decimal(6,2) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `promocion_bonus`
--

INSERT INTO `promocion_bonus` (`id`, `ticket`, `nombre`, `fecha_inicio`, `fecha_fin`, `porcentaje`, `estado`) VALUES
(1, 'XYZABC2019', 'ws', '2019-01-01', '2019-04-04', '20.00', 0),
(2, 'MES DE MARZO', 'EMPANADA Y CAFÉ AMERICANO', '2019-03-10', '2019-03-30', '500.00', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `promocion_puntos`
--

CREATE TABLE `promocion_puntos` (
  `id` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad_puntos` int(11) NOT NULL,
  `cantidad_producto` int(11) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `promocion_puntos`
--

INSERT INTO `promocion_puntos` (`id`, `id_producto`, `cantidad_puntos`, `cantidad_producto`, `estado`) VALUES
(1, 1, 25, 1, 1),
(2, 1, 70, 2, 1),
(3, 1, 100, 3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `serie_comprobante`
--

CREATE TABLE `serie_comprobante` (
  `id` int(11) NOT NULL,
  `id_tipo_comprobante` char(2) NOT NULL,
  `numero` int(11) NOT NULL,
  `correlativo` int(11) NOT NULL DEFAULT '1',
  `estado` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `serie_comprobante`
--

INSERT INTO `serie_comprobante` (`id`, `id_tipo_comprobante`, `numero`, `correlativo`, `estado`) VALUES
(1, '01', 1, 5, 1),
(2, '01', 2, 1, 1),
(3, '03', 1, 116, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_comprobante`
--

CREATE TABLE `tipo_comprobante` (
  `id` char(2) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `abreviatura` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipo_comprobante`
--

INSERT INTO `tipo_comprobante` (`id`, `nombre`, `abreviatura`) VALUES
('01', 'FACTURA', 'FA'),
('03', 'BOLETA', 'BO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_empleado`
--

CREATE TABLE `tipo_empleado` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(75) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipo_empleado`
--

INSERT INTO `tipo_empleado` (`id`, `descripcion`, `estado`) VALUES
(1, 'ADMINISTRADOR', 1),
(2, 'MESERO', 1),
(3, 'CAJERO', 1),
(4, 'COCINERO', 1),
(5, 'BAR', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_servicio`
--

CREATE TABLE `tipo_servicio` (
  `id` int(11) NOT NULL,
  `nombre` varchar(75) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '1',
  `abreviatura` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipo_servicio`
--

INSERT INTO `tipo_servicio` (`id`, `nombre`, `estado`, `abreviatura`) VALUES
(1, 'BAR', 1, 'BA'),
(2, 'COCINA', 1, 'CO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `toma_pedido`
--

CREATE TABLE `toma_pedido` (
  `id` int(11) NOT NULL,
  `id_pedido` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '1',
  `nota` text NOT NULL,
  `kpi` text,
  `observaciones` text NOT NULL,
  `item` int(11) NOT NULL,
  `timbre` int(11) NOT NULL DEFAULT '1',
  `id_facturacion` int(11) NOT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `toma_pedido`
--

INSERT INTO `toma_pedido` (`id`, `id_pedido`, `id_producto`, `cantidad`, `precio`, `estado`, `nota`, `kpi`, `observaciones`, `item`, `timbre`, `id_facturacion`, `fecha_registro`) VALUES
(1, 1, 19, 2, '8.00', 6, '', '11 : 31', '', 0, 0, 1, '2019-08-11 03:21:03'),
(2, 2, 2, 2, '8.00', 6, '', '15 : 00', '', 1, 0, 2, '2019-08-11 03:21:03'),
(3, 2, 47, 2, '5.00', 6, '', '08 : 46', '', 0, 0, 2, '2019-08-11 03:21:03'),
(4, 3, 1, 2, '8.00', 6, '', '12 : 06', '', 1, 0, 3, '2019-08-11 03:21:03'),
(5, 3, 13, 1, '3.00', 6, '', '01 : 06', '', 0, 0, 3, '2019-08-11 03:21:03'),
(6, 4, 7, 1, '6.00', 6, '', '14 : 39', '', 1, 0, 4, '2019-08-11 03:21:03'),
(7, 4, 47, 1, '5.00', 6, '', '09 : 56', '', 0, 0, 4, '2019-08-11 03:21:03'),
(8, 4, 35, 2, '12.00', 6, '', '05 : 19', '', 0, 0, 4, '2019-08-11 03:21:03'),
(9, 3, 24, 1, '8.00', 6, '', '00 : 29', '', 0, 0, 3, '2019-08-11 03:21:03'),
(10, 3, 39, 1, '15.00', 6, '', '00 : 26', '', 0, 0, 3, '2019-08-11 03:21:03'),
(11, 5, 1, 1, '8.00', 6, '', '14 : 45', '', 1, 0, 5, '2019-08-11 03:21:03'),
(12, 5, 6, 1, '6.00', 6, '', '14 : 44', '', 1, 0, 5, '2019-08-11 03:21:03'),
(13, 5, 3, 1, '4.00', 6, '', '14 : 55', '', 0, 0, 5, '2019-08-11 03:21:03'),
(14, 5, 20, 2, '5.00', 6, '', '04 : 12', '', 0, 0, 5, '2019-08-11 03:21:03'),
(15, 6, 2, 1, '8.00', 6, '', '10 : 56', '', 1, 0, 6, '2019-08-11 03:21:03'),
(16, 6, 11, 1, '15.00', 6, '', '10 : 59', '', 0, 0, 6, '2019-08-11 03:21:03'),
(17, 6, 48, 1, '5.00', 6, '', '10 : 58', '', 0, 0, 6, '2019-08-11 03:21:03'),
(18, 6, 20, 2, '5.00', 6, '', '00 : 02', '', 0, 0, 6, '2019-08-11 03:21:03'),
(19, 6, 33, 1, '2.50', 6, '', '00 : 04', '', 0, 0, 6, '2019-08-11 03:21:03'),
(20, 6, 47, 1, '5.00', 6, '', '00 : 01', '', 0, 0, 6, '2019-08-11 03:21:03'),
(21, 5, 20, 1, '5.00', 6, '', '04 : 27', '', 0, 0, 5, '2019-08-11 03:21:03'),
(22, 6, 48, 1, '5.00', 6, '', '02 : 57', '', 0, 0, 6, '2019-08-11 03:21:03'),
(23, 7, 1, 1, '8.00', 6, '', '12 : 56', '', 1, 0, 7, '2019-08-11 03:21:03'),
(24, 7, 2, 1, '8.00', 6, '', '13 : 50', '', 1, 0, 7, '2019-08-11 03:21:03'),
(25, 7, 12, 1, '3.00', 6, '', '01 : 46', '', 0, 0, 7, '2019-08-11 03:21:03'),
(26, 7, 33, 1, '2.50', 6, '', '01 : 47', '', 0, 0, 7, '2019-08-11 03:21:03'),
(27, 7, 16, 1, '4.00', 6, '', '05 : 17', '', 0, 0, 7, '2019-08-11 03:21:03'),
(28, 8, 23, 2, '8.00', 6, '', '05 : 16', '', 0, 0, 8, '2019-08-11 03:21:03'),
(29, 5, 39, 1, '15.00', 6, '', '00 : 05', '', 0, 0, 5, '2019-08-11 03:21:03'),
(30, 9, 1, 2, '8.00', 6, '', '03 : 14', '', 1, 0, 13, '2019-08-11 03:21:03'),
(31, 9, 2, 2, '8.00', 6, '', '03 : 16', '', 1, 0, 13, '2019-08-11 03:21:03'),
(32, 9, 20, 2, '5.00', 6, '', '03 : 41', '', 0, 0, 13, '2019-08-11 03:21:03'),
(33, 9, 22, 1, '8.00', 6, '', '06 : 38', '', 0, 0, 13, '2019-08-11 03:21:03'),
(34, 10, 1, 1, '8.00', 6, '', '00 : 46', '', 1, 0, 12, '2019-08-11 03:21:03'),
(35, 10, 42, 2, '7.00', 6, '', '15 : 00', '', 0, 0, 12, '2019-08-11 03:21:03'),
(36, 10, 48, 1, '5.00', 6, '', '13 : 09', '', 0, 0, 12, '2019-08-11 03:21:03'),
(37, 10, 20, 1, '5.00', 6, '', '03 : 46', '', 0, 0, 12, '2019-08-11 03:21:03'),
(38, 10, 33, 1, '2.50', 6, '', '03 : 45', '', 0, 0, 12, '2019-08-11 03:21:03'),
(39, 10, 47, 1, '5.00', 6, '', '03 : 46', '', 0, 0, 12, '2019-08-11 03:21:03'),
(40, 11, 11, 1, '15.00', 6, 'Majote', '02 : 12', '', 0, 0, 15, '2019-08-11 03:21:03'),
(41, 11, 15, 1, '3.50', 6, '', '01 : 16', '', 0, 0, 15, '2019-08-11 03:21:03'),
(42, 12, 2, 1, '8.00', 6, '', '15 : 00', '', 1, 0, 9, '2019-08-11 03:21:03'),
(43, 12, 1, 1, '8.00', 6, '', '15 : 00', '', 2, 0, 9, '2019-08-11 03:21:03'),
(44, 12, 1, 1, '8.00', 6, '', '15 : 00', '', 3, 0, 9, '2019-08-11 03:21:03'),
(45, 12, 16, 1, '4.00', 6, '', '02 : 39', '', 0, 0, 9, '2019-08-11 03:21:03'),
(46, 12, 24, 1, '8.00', 6, '', '04 : 39', '', 0, 0, 9, '2019-08-11 03:21:03'),
(47, 13, 8, 2, '6.00', 6, '', '15 : 00', '', 1, 0, 11, '2019-08-11 03:21:03'),
(48, 13, 20, 2, '5.00', 6, '', '04 : 40', '', 0, 0, 11, '2019-08-11 03:21:03'),
(49, 13, 47, 1, '5.00', 6, '', '04 : 39', '', 0, 0, 11, '2019-08-11 03:21:03'),
(50, 9, 1, 1, '8.00', 6, '', '03 : 54', '', 1, 0, 13, '2019-08-11 03:21:03'),
(51, 9, 2, 1, '8.00', 6, '', '04 : 28', '', 2, 0, 13, '2019-08-11 03:21:03'),
(52, 9, 2, 1, '8.00', 6, '', '04 : 23', '', 3, 0, 13, '2019-08-11 03:21:03'),
(53, 12, 26, 1, '8.00', 6, '', '03 : 45', '', 0, 0, 9, '2019-08-11 03:21:03'),
(54, 13, 47, 1, '5.00', 6, '', '04 : 00', '', 0, 0, 11, '2019-08-11 03:21:03'),
(55, 13, 8, 1, '6.00', 6, '', '00 : 23', '', 1, 0, 11, '2019-08-11 03:21:03'),
(56, 14, 1, 1, '8.00', 6, '', '08 : 59', '', 1, 0, 14, '2019-08-11 03:21:03'),
(57, 14, 42, 2, '7.00', 6, '', '05 : 31', '', 0, 0, 14, '2019-08-11 03:21:03'),
(58, 14, 17, 1, '5.00', 6, '', '14 : 23', '', 0, 0, 14, '2019-08-11 03:21:03'),
(59, 14, 18, 1, '6.00', 6, '', '11 : 53', '', 0, 0, 14, '2019-08-11 03:21:03'),
(60, 14, 19, 1, '8.00', 6, '', '14 : 24', '', 0, 0, 14, '2019-08-11 03:21:03'),
(61, 14, 20, 2, '5.00', 6, '', '11 : 48', '', 0, 0, 14, '2019-08-11 03:21:03'),
(62, 14, 23, 4, '8.00', 6, '', '15 : 00', '', 0, 0, 14, '2019-08-11 03:21:03'),
(63, 14, 26, 1, '8.00', 6, '', '15 : 00', '', 0, 0, 14, '2019-08-11 03:21:03'),
(64, 12, 1, 1, '8.00', 6, '', '08 : 56', '', 1, 0, 9, '2019-08-11 03:21:03'),
(65, 13, 6, 1, '6.00', 6, '', NULL, '', 1, 0, 0, '2019-08-11 03:21:03'),
(66, 13, 8, 1, '6.00', 6, '', '00 : 08', '', 1, 0, 11, '2019-08-11 03:21:03'),
(67, 14, 42, 1, '7.00', 6, '', '06 : 46', '', 0, 0, 14, '2019-08-11 03:21:03'),
(68, 13, 47, 1, '5.00', 6, '', '00 : 22', '', 0, 0, 11, '2019-08-11 03:21:03'),
(69, 15, 21, 1, '12.00', 6, '', '04 : 18', '', 0, 0, 10, '2019-08-11 03:21:03'),
(70, 16, 8, 1, '6.00', 6, '', '00 : 03', '', 1, 0, 17, '2019-08-11 03:21:03'),
(71, 16, 4, 1, '7.00', 6, '', '00 : 02', '', 0, 0, 17, '2019-08-11 03:21:03'),
(72, 16, 24, 1, '8.00', 6, '', '15 : 00', '', 0, 0, 17, '2019-08-11 03:21:03'),
(73, 17, 41, 1, '3.50', 6, '', '12 : 15', '', 0, 0, 16, '2019-08-11 03:21:03'),
(74, 17, 23, 2, '8.00', 6, '', '05 : 07', '', 0, 0, 16, '2019-08-11 03:21:03'),
(75, 18, 21, 1, '12.00', 6, '', '06 : 23', '', 0, 0, 18, '2019-08-11 03:21:03'),
(76, 16, 9, 1, '3.50', 6, '', '03 : 26', '', 1, 0, 17, '2019-08-11 03:21:03'),
(77, 16, 22, 1, '8.00', 6, '', '06 : 53', '', 0, 0, 17, '2019-08-11 03:21:03'),
(78, 19, 15, 1, '3.50', 6, '', '02 : 02', '', 0, 0, 19, '2019-08-11 03:21:03'),
(79, 19, 20, 1, '5.00', 6, '', '06 : 35', '', 0, 0, 19, '2019-08-11 03:21:03'),
(80, 19, 42, 1, '7.00', 6, '', '13 : 14', '', 0, 0, 19, '2019-08-11 03:21:03'),
(81, 20, 36, 2, '10.00', 6, '', '06 : 42', '', 0, 0, 21, '2019-08-11 03:21:03'),
(82, 19, 1, 1, '8.00', 6, '', '15 : 00', '', 1, 0, 19, '2019-08-11 03:21:03'),
(83, 21, 20, 1, '5.00', 6, '', '09 : 16', '', 0, 0, 20, '2019-08-11 03:21:03'),
(84, 21, 22, 1, '8.00', 6, '', '09 : 18', '', 0, 0, 20, '2019-08-11 03:21:03'),
(85, 21, 47, 1, '5.00', 6, '', '05 : 42', '', 0, 0, 20, '2019-08-11 03:21:03'),
(86, 20, 9, 1, '3.50', 6, '', '12 : 50', '', 1, 0, 21, '2019-08-11 03:21:03'),
(87, 20, 6, 1, '6.00', 6, '', '11 : 45', '', 2, 0, 21, '2019-08-11 03:21:03'),
(88, 20, 15, 1, '3.50', 6, '', '07 : 37', '', 0, 0, 21, '2019-08-11 03:21:03'),
(89, 20, 20, 1, '5.00', 6, '', '07 : 38', '', 0, 0, 21, '2019-08-11 03:21:03'),
(90, 20, 20, 2, '5.00', 6, '', '00 : 07', '', 0, 0, 21, '2019-08-11 03:21:03'),
(91, 22, 2, 1, '8.00', 6, '', '15 : 00', '', 1, 0, 22, '2019-08-11 03:21:03'),
(92, 22, 24, 1, '8.00', 6, '', '15 : 00', '', 0, 0, 22, '2019-08-11 03:21:03'),
(93, 23, 8, 1, '6.00', 6, '', '11 : 11', '', 1, 0, 23, '2019-08-11 03:21:03'),
(94, 23, 41, 1, '3.50', 6, '', '10 : 57', '', 0, 0, 23, '2019-08-11 03:21:03'),
(95, 23, 20, 1, '5.00', 6, '', '14 : 26', '', 0, 0, 23, '2019-08-11 03:21:03'),
(96, 23, 22, 1, '8.00', 6, '', '14 : 28', '', 0, 0, 23, '2019-08-11 03:21:03'),
(97, 23, 29, 1, '3.50', 6, '', '14 : 29', '', 0, 0, 23, '2019-08-11 03:21:03'),
(98, 23, 7, 1, '8.00', 6, '', '10 : 58', '', 1, 0, 23, '2019-08-11 03:21:03'),
(99, 34, 37, 2, '10.00', 6, '', '09 : 33', '', 0, 0, 27, '2019-08-11 03:21:03'),
(100, 22, 51, 1, '10.00', 6, '', '00 : 17', '', 0, 0, 22, '2019-08-11 03:21:03'),
(101, 34, 37, 1, '10.00', 6, '', '04 : 22', '', 0, 0, 27, '2019-08-11 03:21:03'),
(102, 24, 1, 1, '8.00', 6, '', '03 : 33', '', 1, 0, 24, '2019-08-11 03:21:03'),
(103, 24, 2, 1, '8.00', 6, '', '07 : 37', '', 1, 0, 24, '2019-08-11 03:21:03'),
(104, 24, 51, 2, '10.00', 6, '', '03 : 41', '', 0, 0, 24, '2019-08-11 03:21:03'),
(105, 24, 22, 1, '8.00', 6, '', '09 : 12', '', 0, 0, 24, '2019-08-11 03:21:03'),
(106, 24, 23, 1, '8.00', 6, '', '09 : 14', '', 0, 0, 24, '2019-08-11 03:21:03'),
(107, 25, 48, 1, '5.00', 6, '', '08 : 31', '', 0, 0, 25, '2019-08-11 03:21:03'),
(108, 25, 8, 1, '6.00', 6, '', '02 : 37', '', 1, 0, 25, '2019-08-11 03:21:03'),
(109, 25, 23, 1, '8.00', 6, '', '08 : 13', '', 0, 0, 25, '2019-08-11 03:21:03'),
(110, 25, 47, 1, '5.00', 6, '', '08 : 54', '', 0, 0, 25, '2019-08-11 03:21:03'),
(111, 26, 1, 1, '8.00', 6, '', '01 : 57', '', 1, 0, 26, '2019-08-11 03:21:03'),
(112, 26, 42, 1, '7.00', 6, '', '00 : 04', '', 0, 0, 26, '2019-08-11 03:21:03'),
(113, 25, 8, 1, '6.00', 6, '', '02 : 40', '', 1, 0, 25, '2019-08-11 03:21:03'),
(114, 27, 16, 1, '4.00', 6, '', '14 : 27', '', 0, 0, 28, '2019-08-11 03:21:03'),
(115, 27, 20, 1, '5.00', 6, '', '14 : 28', '', 0, 0, 28, '2019-08-11 03:21:03'),
(116, 27, 22, 1, '8.00', 6, '', '14 : 27', '', 0, 0, 28, '2019-08-11 03:21:03'),
(117, 28, 8, 8, '6.00', 6, '', '00 : 02', '', 1, 0, 29, '2019-08-11 03:21:03'),
(118, 29, 14, 1, '3.00', 6, '', '00 : 43', '', 0, 0, 32, '2019-08-11 03:21:03'),
(119, 30, 2, 1, '8.00', 6, '', '15 : 00', '', 1, 0, 30, '2019-08-11 03:21:03'),
(120, 30, 8, 1, '6.00', 6, '', '15 : 00', '', 1, 0, 30, '2019-08-11 03:21:03'),
(121, 30, 8, 1, '6.00', 6, '', '15 : 00', '', 2, 0, 30, '2019-08-11 03:21:03'),
(122, 30, 8, 1, '6.00', 6, '', '15 : 00', '', 3, 0, 30, '2019-08-11 03:21:03'),
(123, 30, 20, 4, '5.00', 6, '', '11 : 04', '', 0, 0, 30, '2019-08-11 03:21:03'),
(124, 29, 20, 1, '5.00', 6, '', '06 : 08', '', 0, 0, 32, '2019-08-11 03:21:03'),
(125, 30, 52, 1, '2.00', 6, '', '04 : 07', '', 0, 0, 30, '2019-08-11 03:21:03'),
(126, 30, 20, 1, '5.00', 6, '', '04 : 53', '', 0, 0, 30, '2019-08-11 03:21:03'),
(127, 29, 15, 1, '3.50', 6, '', '06 : 45', '', 0, 0, 32, '2019-08-11 03:21:03'),
(128, 29, 12, 1, '3.00', 6, '', '00 : 03', '', 0, 0, 32, '2019-08-11 03:21:03'),
(129, 29, 15, 1, '3.50', 6, '', '00 : 05', '', 0, 0, 32, '2019-08-11 03:21:03'),
(130, 29, 20, 1, '5.00', 6, '', '07 : 08', '', 0, 0, 32, '2019-08-11 03:21:03'),
(131, 30, 2, 1, '8.00', 6, '', '14 : 06', '', 1, 0, 31, '2019-08-11 03:21:03'),
(132, 30, 8, 1, '6.00', 6, '', '08 : 24', '', 1, 0, 31, '2019-08-11 03:21:03'),
(133, 30, 8, 1, '6.00', 6, '', '08 : 22', '', 2, 0, 31, '2019-08-11 03:21:03'),
(134, 30, 8, 1, '6.00', 6, '', '08 : 21', '', 3, 0, 31, '2019-08-11 03:21:03'),
(135, 30, 8, 1, '6.00', 6, '', '08 : 20', '', 4, 0, 31, '2019-08-11 03:21:03'),
(136, 30, 20, 3, '5.00', 6, '', '07 : 05', '', 0, 0, 31, '2019-08-11 03:21:03'),
(137, 30, 24, 1, '8.00', 6, '', '07 : 05', '', 0, 0, 31, '2019-08-11 03:21:03'),
(138, 30, 8, 1, '6.00', 6, '', '15 : 00', '', 1, 0, 31, '2019-08-11 03:21:03'),
(139, 30, 24, 1, '8.00', 6, '', '04 : 19', '', 0, 0, 31, '2019-08-11 03:21:03'),
(140, 30, 29, 1, '3.50', 6, '', '02 : 58', '', 0, 0, 31, '2019-08-11 03:21:03'),
(141, 21, 21, 1, '12.00', 6, '', '00 : 02', '', 0, 0, 33, '2019-08-11 03:21:03'),
(142, 21, 22, 1, '8.00', 6, '', '02 : 37', '', 0, 0, 33, '2019-08-11 03:21:03'),
(143, 31, 1, 1, '8.00', 6, '', '07 : 12', '', 1, 0, 36, '2019-08-11 03:21:03'),
(144, 31, 1, 1, '8.00', 6, '', '08 : 32', '', 1, 0, 36, '2019-08-11 03:21:03'),
(145, 31, 20, 1, '5.00', 6, '', '09 : 28', '', 0, 0, 36, '2019-08-11 03:21:03'),
(146, 31, 2, 1, '8.00', 6, '', '08 : 58', '', 1, 0, 36, '2019-08-11 03:21:03'),
(147, 21, 22, 1, '8.00', 6, '', NULL, '', 0, 0, 0, '2019-08-11 03:21:03'),
(148, 21, 24, 1, '8.00', 6, '', NULL, '', 0, 0, 0, '2019-08-11 03:21:03'),
(149, 32, 22, 1, '8.00', 6, '', '05 : 46', '', 0, 0, 34, '2019-08-11 03:21:03'),
(150, 32, 24, 1, '8.00', 6, '', '05 : 50', '', 0, 0, 34, '2019-08-11 03:21:03'),
(151, 33, 1, 1, '8.00', 6, '', '00 : 01', '', 1, 0, 35, '2019-08-11 03:21:03'),
(152, 33, 11, 1, '15.00', 6, '', '00 : 01', '', 0, 0, 35, '2019-08-11 03:21:03'),
(153, 34, 10, 2, '15.00', 6, '', '00 : 01', '', 0, 0, 37, '2019-08-11 03:21:03'),
(154, 35, 3, 1, '4.00', 6, '', '03 : 37', '', 0, 0, 38, '2019-08-11 03:21:03'),
(155, 35, 15, 1, '3.50', 6, '', '00 : 04', '', 0, 0, 38, '2019-08-11 03:21:03'),
(156, 35, 31, 1, '5.00', 6, '', '00 : 03', '', 0, 0, 38, '2019-08-11 03:21:03'),
(157, 32, 8, 1, '6.00', 6, '', '08 : 01', '', 1, 0, 40, '2019-08-11 03:21:03'),
(158, 32, 20, 3, '5.00', 6, '', '04 : 09', '', 0, 0, 40, '2019-08-11 03:21:03'),
(159, 32, 27, 1, '8.00', 6, '', '06 : 56', '', 0, 0, 40, '2019-08-11 03:21:03'),
(160, 36, 8, 1, '6.00', 6, '', '09 : 49', '', 1, 0, 39, '2019-08-11 03:21:03'),
(161, 36, 23, 1, '8.00', 6, '', NULL, '', 0, 0, 0, '2019-08-11 03:21:03'),
(162, 36, 16, 1, '4.00', 6, '', '00 : 36', '', 0, 0, 50, '2019-08-11 03:21:03'),
(163, 32, 35, 4, '12.00', 6, '', '00 : 01', '', 0, 0, 40, '2019-08-11 03:21:03'),
(164, 32, 6, 1, '6.00', 6, '', '00 : 41', '', 1, 0, 40, '2019-08-11 03:21:03'),
(165, 36, 8, 1, '6.00', 6, '', '09 : 51', '', 1, 0, 50, '2019-08-11 03:21:03'),
(166, 36, 16, 3, '4.00', 6, '', '00 : 13', '', 0, 0, 39, '2019-08-11 03:21:03'),
(167, 37, 8, 1, '6.00', 6, '', '07 : 18', '', 1, 0, 44, '2019-08-11 03:21:03'),
(168, 37, 8, 1, '6.00', 6, '', '05 : 15', '', 2, 0, 44, '2019-08-11 03:21:03'),
(169, 37, 16, 2, '4.00', 6, '', '01 : 50', '', 0, 0, 44, '2019-08-11 03:21:03'),
(170, 38, 22, 1, '8.00', 6, '', '11 : 11', '', 0, 0, 42, '2019-08-11 03:21:03'),
(171, 38, 23, 1, '8.00', 6, '', '11 : 12', '', 0, 0, 42, '2019-08-11 03:21:03'),
(172, 37, 11, 1, '15.00', 6, '', '15 : 00', '', 0, 0, 44, '2019-08-11 03:21:03'),
(173, 37, 23, 1, '8.00', 6, '', '05 : 29', '', 0, 0, 44, '2019-08-11 03:21:03'),
(174, 37, 23, 2, '8.00', 6, '', '03 : 17', '', 0, 0, 44, '2019-08-11 03:21:03'),
(175, 39, 1, 1, '8.00', 6, '', '03 : 26', '', 1, 0, 48, '2019-08-11 03:21:03'),
(176, 39, 8, 1, '6.00', 6, '', '03 : 28', '', 1, 0, 48, '2019-08-11 03:21:03'),
(177, 39, 20, 1, '5.00', 6, '', '03 : 58', '', 0, 0, 48, '2019-08-11 03:21:03'),
(178, 39, 22, 1, '8.00', 6, '', '05 : 35', '', 0, 0, 48, '2019-08-11 03:21:03'),
(179, 40, 1, 2, '8.00', 6, '', '03 : 51', '', 1, 0, 43, '2019-08-11 03:21:03'),
(180, 40, 8, 2, '6.00', 6, '', '03 : 50', '', 1, 0, 43, '2019-08-11 03:21:03'),
(181, 40, 24, 1, '8.00', 6, '', '08 : 42', '', 0, 0, 43, '2019-08-11 03:21:03'),
(182, 40, 47, 1, '5.00', 6, '', '10 : 46', '', 0, 0, 43, '2019-08-11 03:21:03'),
(183, 37, 11, 1, '15.00', 6, '', '12 : 48', '', 0, 0, 44, '2019-08-11 03:21:03'),
(184, 36, 8, 1, '6.00', 6, '', '03 : 16', '', 1, 0, 50, '2019-08-11 03:21:03'),
(185, 36, 8, 1, '6.00', 6, '', '03 : 13', '', 2, 0, 50, '2019-08-11 03:21:03'),
(186, 36, 20, 2, '5.00', 6, '', '07 : 18', '', 0, 0, 50, '2019-08-11 03:21:03'),
(187, 37, 8, 1, '6.00', 6, '', '14 : 41', '', 1, 0, 44, '2019-08-11 03:21:03'),
(188, 36, 21, 1, '12.00', 6, '', '05 : 01', '', 0, 0, 50, '2019-08-11 03:21:03'),
(189, 41, 1, 1, '8.00', 6, '', '15 : 00', '', 1, 0, 46, '2019-08-11 03:21:03'),
(190, 41, 1, 1, '8.00', 6, '', '09 : 02', '', 2, 0, 46, '2019-08-11 03:21:03'),
(191, 41, 8, 1, '6.00', 6, '', '15 : 00', '', 1, 0, 46, '2019-08-11 03:21:03'),
(192, 41, 8, 1, '6.00', 6, '', '15 : 00', '', 2, 0, 46, '2019-08-11 03:21:03'),
(193, 41, 3, 1, '4.00', 6, '', '15 : 00', '', 0, 0, 46, '2019-08-11 03:21:03'),
(194, 41, 21, 3, '12.00', 6, '', '06 : 11', '', 0, 0, 46, '2019-08-11 03:21:03'),
(195, 42, 3, 1, '4.00', 6, '', '15 : 00', '', 0, 0, 45, '2019-08-11 03:21:03'),
(196, 42, 16, 2, '4.00', 6, '', '06 : 13', '', 0, 0, 45, '2019-08-11 03:21:03'),
(197, 42, 31, 1, '5.00', 6, '', '00 : 02', '', 0, 0, 45, '2019-08-11 03:21:03'),
(198, 43, 2, 1, '8.00', 6, '', '15 : 00', '', 1, 0, 49, '2019-08-11 03:21:03'),
(199, 43, 8, 1, '6.00', 6, '', '15 : 00', '', 1, 0, 49, '2019-08-11 03:21:03'),
(200, 43, 21, 1, '12.00', 6, '', '00 : 00', '', 0, 0, 49, '2019-08-11 03:21:03'),
(201, 43, 22, 1, '8.00', 6, '', '08 : 58', '', 0, 0, 49, '2019-08-11 03:21:03'),
(202, 44, 14, 1, '3.00', 6, '', NULL, '', 0, 0, 0, '2019-08-11 03:21:03'),
(203, 45, 20, 1, '5.00', 6, '', NULL, '', 0, 0, 0, '2019-08-11 03:21:03'),
(204, 41, 20, 2, '5.00', 6, '', NULL, '', 0, 0, 0, '2019-08-11 03:21:03'),
(205, 41, 47, 2, '5.00', 6, '', '02 : 23', '', 0, 0, 46, '2019-08-11 03:21:03'),
(206, 41, 4, 1, '7.00', 6, '', NULL, '', 0, 0, 0, '2019-08-11 03:21:03'),
(207, 41, 3, 1, '4.00', 6, '', '00 : 06', '', 0, 0, 46, '2019-08-11 03:21:03'),
(208, 46, 6, 1, '6.00', 6, '', '09 : 42', '', 1, 0, 51, '2019-08-11 03:21:03'),
(209, 46, 8, 1, '6.00', 6, '', '09 : 41', '', 1, 0, 51, '2019-08-11 03:21:03'),
(210, 46, 8, 1, '6.00', 6, '', '09 : 41', '', 2, 0, 51, '2019-08-11 03:21:03'),
(211, 46, 42, 1, '7.00', 6, '', '15 : 00', '', 0, 0, 51, '2019-08-11 03:21:03'),
(212, 46, 15, 1, '3.50', 6, '', '00 : 22', '', 0, 0, 51, '2019-08-11 03:21:03'),
(213, 46, 16, 1, '4.00', 6, '', '04 : 56', '', 0, 0, 51, '2019-08-11 03:21:03'),
(214, 46, 20, 1, '5.00', 6, '', '00 : 23', '', 0, 0, 51, '2019-08-11 03:21:03'),
(215, 46, 29, 1, '3.50', 6, '', '04 : 51', '', 0, 0, 51, '2019-08-11 03:21:03'),
(216, 47, 15, 2, '3.50', 6, '', '03 : 04', '', 0, 0, 52, '2019-08-11 03:21:03'),
(217, 48, 22, 2, '8.00', 6, '', '01 : 29', '', 0, 0, 53, '2019-08-11 03:21:03'),
(218, 49, 4, 1, '7.00', 6, '', '15 : 10', '', 0, 0, 54, '2019-08-11 03:21:03'),
(219, 49, 11, 1, '15.00', 6, '', '15 : 13', '', 0, 0, 54, '2019-08-11 03:21:03'),
(220, 49, 16, 2, '4.00', 6, '', '00 : 04', '', 0, 0, 54, '2019-08-11 03:21:03'),
(221, 50, 21, 1, '12.00', 6, '', '10 : 12', '', 0, 0, 55, '2019-08-11 03:21:03'),
(222, 50, 24, 2, '8.00', 6, '', '10 : 16', '', 0, 0, 55, '2019-08-11 03:21:03'),
(223, 51, 20, 1, '5.00', 6, '', '06 : 36', '', 0, 0, 56, '2019-08-11 03:21:03'),
(224, 51, 24, 2, '8.00', 6, '', '06 : 37', '', 0, 0, 56, '2019-08-11 03:21:03'),
(225, 52, 1, 1, '8.00', 6, '', '15 : 00', '', 1, 0, 61, '2019-08-11 03:21:03'),
(226, 52, 9, 1, '3.50', 6, '', '11 : 39', '', 1, 0, 61, '2019-08-11 03:21:03'),
(227, 52, 16, 2, '4.00', 6, '', '04 : 37', '', 0, 0, 61, '2019-08-11 03:21:03'),
(228, 53, 1, 1, '8.00', 6, '', '07 : 40', '', 1, 0, 58, '2019-08-11 03:21:03'),
(229, 53, 2, 1, '8.00', 6, '', '07 : 38', '', 1, 0, 58, '2019-08-11 03:21:03'),
(230, 53, 23, 2, '8.00', 6, '', '08 : 15', '', 0, 0, 58, '2019-08-11 03:21:03'),
(231, 54, 9, 1, '3.50', 6, '', '00 : 10', '', 1, 0, 59, '2019-08-11 03:21:03'),
(232, 54, 41, 1, '3.50', 6, '', '21 : 03', '', 0, 0, 59, '2019-08-11 03:21:03'),
(233, 54, 20, 1, '5.00', 6, '', '06 : 22', '', 0, 0, 59, '2019-08-11 03:21:03'),
(234, 54, 23, 2, '8.00', 6, '', '04 : 17', '', 0, 0, 59, '2019-08-11 03:21:03'),
(235, 54, 41, 1, '3.50', 6, '', '21 : 14', '', 0, 0, 59, '2019-08-11 03:21:03'),
(236, 55, 39, 1, '15.00', 6, '', '00 : 30', '', 0, 0, 57, '2019-08-11 03:21:03'),
(237, 56, 8, 1, '6.00', 6, '', '06 : 46', '', 1, 0, 60, '2019-08-11 03:21:03'),
(238, 56, 9, 1, '3.50', 6, '', '06 : 45', '', 1, 0, 60, '2019-08-11 03:21:03'),
(239, 56, 20, 1, '5.00', 6, '', '03 : 30', '', 0, 0, 60, '2019-08-11 03:21:03'),
(240, 56, 29, 1, '3.50', 6, '', '03 : 29', '', 0, 0, 60, '2019-08-11 03:21:03'),
(241, 54, 9, 1, '3.50', 6, '', '00 : 39', '', 1, 0, 59, '2019-08-11 03:21:03'),
(242, 52, 9, 1, '3.50', 6, '', '05 : 54', '', 1, 0, 61, '2019-08-11 03:21:03'),
(243, 52, 20, 1, '5.00', 6, '', '04 : 01', '', 0, 0, 61, '2019-08-11 03:21:03'),
(244, 57, 8, 1, '6.00', 6, '', '11 : 17', '', 1, 0, 62, '2019-08-11 03:21:03'),
(245, 57, 8, 1, '6.00', 6, '', '11 : 18', '', 2, 0, 62, '2019-08-11 03:21:03'),
(246, 57, 16, 2, '4.00', 6, '', '05 : 12', '', 0, 0, 62, '2019-08-11 03:21:03'),
(247, 58, 6, 1, '6.00', 6, '', '03 : 07', '', 1, 0, 63, '2019-08-11 03:21:03'),
(248, 58, 8, 1, '6.00', 6, '', '03 : 03', '', 1, 0, 63, '2019-08-11 03:21:03'),
(249, 58, 21, 1, '12.00', 6, '', '06 : 48', '', 0, 0, 63, '2019-08-11 03:21:03'),
(250, 58, 23, 1, '8.00', 6, '', '06 : 48', '', 0, 0, 63, '2019-08-11 03:21:03'),
(251, 57, 8, 1, '6.00', 6, '', '07 : 44', '', 1, 0, 62, '2019-08-11 03:21:03'),
(252, 59, 37, 1, '10.00', 6, '', '06 : 12', '', 0, 0, 68, '2019-08-11 03:21:03'),
(253, 60, 31, 1, '5.00', 6, '', '01 : 09', '', 0, 0, 64, '2019-08-11 03:21:03'),
(254, 59, 8, 1, '6.00', 6, '', '03 : 31', '', 1, 0, 68, '2019-08-11 03:21:03'),
(255, 59, 27, 1, '8.00', 6, '', '04 : 53', '', 0, 0, 68, '2019-08-11 03:21:03'),
(256, 61, 6, 1, '6.00', 6, '', '09 : 06', '', 1, 0, 66, '2019-08-11 03:21:03'),
(257, 61, 41, 1, '3.50', 6, '', '12 : 41', '', 0, 0, 66, '2019-08-11 03:21:03'),
(258, 61, 12, 1, '3.00', 6, '', '06 : 18', '', 0, 0, 66, '2019-08-11 03:21:03'),
(259, 61, 19, 1, '8.00', 6, '', '08 : 56', '', 0, 0, 66, '2019-08-11 03:21:03'),
(260, 61, 20, 1, '5.00', 6, '', '06 : 16', '', 0, 0, 66, '2019-08-11 03:21:03'),
(261, 62, 8, 2, '6.00', 6, '', '06 : 22', '', 1, 0, 65, '2019-08-11 03:21:03'),
(262, 62, 20, 1, '5.00', 6, '', '10 : 56', '', 0, 0, 65, '2019-08-11 03:21:03'),
(263, 62, 47, 1, '5.00', 6, '', '10 : 57', '', 0, 0, 65, '2019-08-11 03:21:03'),
(264, 63, 13, 1, '3.00', 6, '', '02 : 12', '', 0, 0, 67, '2019-08-11 03:21:03'),
(265, 63, 15, 1, '3.50', 6, '', '02 : 11', '', 0, 0, 67, '2019-08-11 03:21:03'),
(266, 63, 20, 1, '5.00', 6, '', '06 : 04', '', 0, 0, 67, '2019-08-11 03:21:03'),
(267, 64, 20, 2, '5.00', 6, '', '03 : 46', '', 0, 0, 71, '2019-08-11 03:21:03'),
(268, 65, 8, 1, '6.00', 6, '', '04 : 26', '', 1, 0, 71, '2019-08-11 03:21:03'),
(269, 65, 21, 1, '12.00', 6, '', '09 : 07', '', 0, 0, 71, '2019-08-11 03:21:03'),
(270, 65, 23, 1, '8.00', 6, '', '09 : 06', '', 0, 0, 71, '2019-08-11 03:21:03'),
(271, 66, 1, 1, '8.00', 6, '', '12 : 42', '', 1, 0, 69, '2019-08-11 03:21:03'),
(272, 66, 23, 1, '8.00', 6, '', '06 : 10', '', 0, 0, 69, '2019-08-11 03:21:03'),
(273, 66, 26, 1, '8.00', 6, '', '06 : 12', '', 0, 0, 69, '2019-08-11 03:21:03'),
(274, 67, 20, 1, '5.00', 6, '', '07 : 51', '', 0, 0, 70, '2019-08-11 03:21:03'),
(275, 67, 23, 1, '8.00', 6, '', '07 : 52', '', 0, 0, 70, '2019-08-11 03:21:03'),
(276, 65, 37, 2, '10.00', 6, '', '02 : 25', '', 0, 0, 71, '2019-08-11 03:21:03'),
(277, 68, 21, 1, '12.00', 6, '', '25 : 21', '', 0, 0, 72, '2019-08-11 03:21:03'),
(278, 68, 8, 2, '6.00', 6, '', '10 : 24', '', 1, 0, 72, '2019-08-11 03:21:03'),
(279, 69, 37, 3, '10.00', 6, '', '09 : 13', '', 0, 0, 73, '2019-08-11 03:21:03'),
(280, 64, 12, 1, '3.00', 6, '', NULL, '', 0, 0, 0, '2019-08-11 03:21:03'),
(281, 65, 12, 1, '3.00', 6, '', NULL, '', 0, 0, 0, '2019-08-11 03:21:03'),
(282, 70, 12, 1, '3.00', 6, '', NULL, '', 0, 0, 0, '2019-08-11 03:21:03'),
(283, 71, 1, 1, '8.00', 6, '', '08 : 25', '', 1, 0, 74, '2019-08-11 03:21:03'),
(284, 71, 8, 1, '6.00', 6, '', '08 : 22', '', 1, 0, 74, '2019-08-11 03:21:03'),
(285, 71, 23, 1, '8.00', 6, '', '07 : 09', '', 0, 0, 74, '2019-08-11 03:21:03'),
(286, 71, 47, 1, '5.00', 6, '', '07 : 10', '', 0, 0, 74, '2019-08-11 03:21:03'),
(287, 72, 8, 1, '6.00', 6, '', '02 : 04', '', 1, 0, 75, '2019-08-11 03:21:03'),
(288, 72, 41, 1, '3.50', 6, '', '16 : 00', '', 0, 0, 75, '2019-08-11 03:21:03'),
(289, 72, 15, 1, '3.50', 6, '', '08 : 01', '', 0, 0, 75, '2019-08-11 03:21:03'),
(290, 72, 23, 1, '8.00', 6, '', '08 : 03', '', 0, 0, 75, '2019-08-11 03:21:03'),
(291, 71, 6, 1, '6.00', 6, '', NULL, 'Partir por la mitat', 1, 0, 0, '2019-08-11 03:21:03'),
(292, 71, 23, 2, '8.00', 6, '', NULL, '', 0, 0, 0, '2019-08-11 03:21:03'),
(293, 73, 1, 1, '8.00', 6, '', '15 : 00', '', 1, 0, 76, '2019-08-11 03:21:03'),
(294, 73, 2, 1, '8.00', 6, '', '15 : 00', '', 1, 0, 76, '2019-08-11 03:21:03'),
(295, 73, 20, 2, '5.00', 6, '', '02 : 48', '', 0, 0, 76, '2019-08-11 03:21:03'),
(296, 74, 1, 1, '8.00', 6, '', '15 : 00', '', 1, 0, 77, '2019-08-11 03:21:03'),
(297, 74, 1, 1, '8.00', 6, '', '15 : 00', '', 2, 0, 77, '2019-08-11 03:21:03'),
(298, 74, 1, 1, '8.00', 6, '', '15 : 00', '', 3, 0, 77, '2019-08-11 03:21:03'),
(299, 74, 47, 3, '5.00', 6, '', '00 : 01', '', 0, 0, 77, '2019-08-11 03:21:03'),
(300, 75, 20, 1, '5.00', 6, '', '03 : 16', '', 0, 0, 78, '2019-08-11 03:21:03'),
(301, 75, 1, 1, '8.00', 6, '', '11 : 16', '', 1, 0, 78, '2019-08-11 03:21:03'),
(302, 76, 1, 1, '8.00', 6, '', '08 : 05', '', 1, 0, 79, '2019-08-11 03:21:03'),
(303, 76, 7, 1, '8.00', 6, '', NULL, '', 2, 0, 0, '2019-08-11 03:21:03'),
(304, 76, 15, 1, '3.50', 6, '', '02 : 47', '', 0, 0, 79, '2019-08-11 03:21:03'),
(305, 76, 16, 1, '4.00', 6, '', '02 : 48', '', 0, 0, 79, '2019-08-11 03:21:03'),
(306, 76, 8, 1, '6.00', 6, '', '08 : 04', '', 2, 0, 79, '2019-08-11 03:21:03'),
(307, 77, 37, 3, '10.00', 6, '', NULL, '', 0, 0, 0, '2019-08-11 03:21:03'),
(308, 78, 52, 5, '2.00', 6, '', NULL, '', 0, 0, 0, '2019-08-11 03:21:03'),
(309, 79, 31, 2, '5.00', 6, '', '00 : 04', '', 0, 0, 80, '2019-08-11 03:21:03'),
(310, 80, 1, 1, '8.00', 6, '', '02 : 45', '', 1, 0, 84, '2019-08-11 03:21:03'),
(311, 80, 6, 1, '6.00', 6, '', '02 : 44', '', 1, 0, 84, '2019-08-11 03:21:03'),
(312, 80, 15, 1, '3.50', 6, '', '02 : 31', '', 0, 0, 84, '2019-08-11 03:21:03'),
(313, 81, 2, 1, '8.00', 6, '', '06 : 57', '', 1, 0, 82, '2019-08-11 03:21:03'),
(314, 81, 24, 1, '8.00', 6, '', '05 : 54', '', 0, 0, 82, '2019-08-11 03:21:03'),
(315, 81, 26, 1, '8.00', 6, '', '05 : 55', '', 0, 0, 82, '2019-08-11 03:21:03'),
(316, 82, 41, 1, '3.50', 6, '', '13 : 09', '', 0, 0, 83, '2019-08-11 03:21:03'),
(317, 82, 20, 1, '5.00', 6, '', '09 : 35', '', 0, 0, 83, '2019-08-11 03:21:03'),
(318, 82, 23, 1, '8.00', 6, '', '09 : 36', '', 0, 0, 83, '2019-08-11 03:21:03'),
(319, 83, 41, 1, '3.50', 6, '', '13 : 06', '', 0, 0, 81, '2019-08-11 03:21:03'),
(320, 83, 23, 2, '8.00', 6, '', '09 : 49', '', 0, 0, 81, '2019-08-11 03:21:03'),
(321, 80, 36, 2, '10.00', 6, '', '07 : 12', '', 0, 0, 84, '2019-08-11 03:21:03'),
(322, 84, 22, 2, '8.00', 6, '', '06 : 18', '', 0, 0, 85, '2019-08-11 03:21:03'),
(323, 84, 15, 1, '3.50', 6, '', '01 : 35', '', 0, 0, 85, '2019-08-11 03:21:03'),
(324, 84, 6, 2, '6.00', 6, '', '00 : 01', '', 1, 0, 85, '2019-08-11 03:21:03'),
(325, 85, 10, 3, '15.00', 6, '', '23 : 45', '', 0, 0, 87, '2019-08-11 03:21:03'),
(326, 85, 15, 1, '3.50', 6, '', NULL, '', 0, 0, 0, '2019-08-11 03:21:03'),
(327, 85, 16, 2, '4.00', 6, '', NULL, '', 0, 0, 0, '2019-08-11 03:21:03'),
(328, 86, 6, 1, '6.00', 6, '', '15 : 00', '', 2, 0, 86, '2019-08-11 03:21:03'),
(329, 86, 8, 1, '6.00', 6, '', '15 : 00', '', 2, 0, 86, '2019-08-11 03:21:03'),
(330, 86, 10, 1, '15.00', 6, '', '23 : 43', '', 0, 0, 86, '2019-08-11 03:21:03'),
(331, 86, 15, 2, '3.50', 6, '', '00 : 05', '', 0, 0, 86, '2019-08-11 03:21:03'),
(332, 87, 6, 1, '6.00', 6, '', '00 : 06', '', 1, 0, 89, '2019-08-11 03:21:03'),
(333, 87, 47, 2, '5.00', 6, '', '00 : 08', '', 0, 0, 89, '2019-08-11 03:21:03'),
(334, 88, 41, 1, '3.50', 6, '', '00 : 03', '', 0, 0, 88, '2019-08-11 03:21:03'),
(335, 88, 13, 1, '3.00', 6, '', '00 : 05', '', 0, 0, 88, '2019-08-11 03:21:03'),
(336, 88, 20, 1, '5.00', 6, '', '00 : 05', '', 0, 0, 88, '2019-08-11 03:21:03'),
(337, 88, 27, 1, '8.00', 6, '', '00 : 07', '', 0, 0, 88, '2019-08-11 03:21:03'),
(338, 89, 1, 1, '8.00', 6, '', '00 : 04', '', 1, 0, 93, '2019-08-11 03:21:03'),
(339, 89, 41, 2, '3.50', 6, '', '00 : 01', '', 0, 0, 93, '2019-08-11 03:21:03'),
(340, 89, 20, 1, '5.00', 6, '', '00 : 04', '', 0, 0, 93, '2019-08-11 03:21:03'),
(341, 89, 33, 1, '2.50', 6, '', '00 : 03', '', 0, 0, 93, '2019-08-11 03:21:03'),
(342, 90, 20, 5, '5.00', 6, '', '00 : 02', '', 0, 0, 90, '2019-08-11 03:21:03'),
(343, 88, 8, 1, '6.00', 6, '', '00 : 09', '', 1, 0, 88, '2019-08-11 03:21:03'),
(344, 91, 3, 1, '4.00', 6, '', '14 : 40', '', 0, 0, 91, '2019-08-11 03:21:03'),
(345, 91, 11, 1, '15.00', 6, '', '14 : 39', '', 0, 0, 91, '2019-08-11 03:21:03'),
(346, 91, 24, 1, '8.00', 6, '', '07 : 22', '', 0, 0, 91, '2019-08-11 03:21:03'),
(347, 91, 26, 1, '8.00', 6, '', '07 : 23', '', 0, 0, 91, '2019-08-11 03:21:03'),
(348, 92, 1, 1, '8.00', 6, '', '15 : 00', '', 1, 0, 92, '2019-08-11 03:21:03'),
(349, 92, 1, 1, '8.00', 6, '', '15 : 00', '', 2, 0, 92, '2019-08-11 03:21:03'),
(350, 92, 20, 1, '5.00', 6, '', '13 : 47', '', 0, 0, 92, '2019-08-11 03:21:03'),
(351, 92, 28, 1, '9.00', 6, '', '13 : 52', '', 0, 0, 92, '2019-08-11 03:21:03'),
(352, 92, 47, 1, '5.00', 6, '', '13 : 48', '', 0, 0, 92, '2019-08-11 03:21:03'),
(353, 92, 31, 1, '5.00', 6, '', '13 : 53', '', 0, 0, 92, '2019-08-11 03:21:03'),
(354, 93, 35, 2, '12.00', 6, '', '06 : 35', '', 0, 0, 94, '2019-08-11 03:21:03'),
(355, 93, 35, 2, '12.00', 6, '', '06 : 41', '', 0, 0, 94, '2019-08-11 03:21:03'),
(356, 93, 35, 6, '12.00', 6, '', NULL, '', 0, 0, 0, '2019-08-11 03:21:03'),
(357, 93, 35, 4, '12.00', 6, '', '00 : 06', '', 0, 0, 94, '2019-08-11 03:21:03'),
(358, 94, 22, 2, '8.00', 6, '', '04 : 04', '', 0, 0, 93, '2019-08-11 03:21:03'),
(359, 89, 35, 2, '12.00', 6, '', '06 : 28', '', 0, 0, 95, '2019-08-11 03:21:03'),
(360, 95, 1, 1, '8.00', 6, '', '15 : 00', '', 1, 0, 97, '2019-08-11 03:21:03'),
(361, 95, 1, 1, '8.00', 6, '', '15 : 00', '', 2, 0, 97, '2019-08-11 03:21:03'),
(362, 95, 23, 2, '8.00', 6, '', '07 : 10', '', 0, 0, 97, '2019-08-11 03:21:03'),
(363, 96, 1, 1, '8.00', 6, '', NULL, '', 1, 0, 0, '2019-08-11 03:21:03'),
(364, 96, 1, 1, '8.00', 6, '', NULL, '', 2, 0, 0, '2019-08-11 03:21:03'),
(365, 96, 23, 2, '8.00', 6, '', NULL, '', 0, 0, 0, '2019-08-11 03:21:03'),
(366, 95, 1, 1, '8.00', 6, '', '15 : 00', '', 1, 0, 97, '2019-08-11 03:21:03'),
(367, 95, 1, 1, '8.00', 6, '', '15 : 00', '', 2, 0, 97, '2019-08-11 03:21:03'),
(368, 95, 8, 2, '6.00', 6, '', '01 : 04', '', 1, 0, 97, '2019-08-11 03:21:03'),
(369, 95, 23, 3, '8.00', 6, '', '09 : 30', '', 0, 0, 97, '2019-08-11 03:21:03'),
(370, 97, 15, 1, '3.50', 6, '', '03 : 31', '', 0, 0, 102, '2019-08-11 03:21:03'),
(371, 97, 20, 1, '5.00', 6, '', '03 : 30', '', 0, 0, 102, '2019-08-11 03:21:03'),
(372, 98, 8, 1, '6.00', 6, '', '05 : 54', '', 1, 0, 99, '2019-08-11 03:21:03'),
(373, 98, 9, 1, '3.50', 6, '', '05 : 54', '', 1, 0, 99, '2019-08-11 03:21:03'),
(374, 98, 8, 1, '6.00', 6, '', '05 : 53', '', 2, 0, 99, '2019-08-11 03:21:03'),
(375, 98, 9, 1, '3.50', 6, '', '05 : 54', '', 2, 0, 99, '2019-08-11 03:21:03'),
(376, 98, 15, 1, '3.50', 6, '', '00 : 01', '', 0, 0, 99, '2019-08-11 03:21:03'),
(377, 98, 16, 1, '4.00', 6, '', '00 : 04', '', 0, 0, 99, '2019-08-11 03:21:03'),
(378, 99, 6, 1, '6.00', 6, '', '07 : 50', '', 1, 0, 96, '2019-08-11 03:21:03'),
(379, 99, 8, 1, '6.00', 6, '', '08 : 19', '', 1, 0, 96, '2019-08-11 03:21:03'),
(380, 99, 29, 1, '3.50', 6, '', '01 : 30', '', 0, 0, 96, '2019-08-11 03:21:03'),
(381, 100, 1, 1, '8.00', 6, '', '15 : 00', '', 1, 0, 97, '2019-08-11 03:21:03'),
(382, 100, 8, 1, '6.00', 6, '', '10 : 33', '', 1, 0, 97, '2019-08-11 03:21:03'),
(383, 100, 15, 1, '3.50', 6, '', '03 : 29', '', 0, 0, 97, '2019-08-11 03:21:03'),
(384, 101, 12, 1, '3.00', 6, '', '05 : 57', '', 0, 0, 98, '2019-08-11 03:21:03'),
(385, 101, 23, 1, '8.00', 6, '', '05 : 58', '', 0, 0, 98, '2019-08-11 03:21:03'),
(386, 98, 37, 3, '10.00', 6, '', '17 : 24', '', 0, 0, 99, '2019-08-11 03:21:03'),
(387, 100, 26, 1, '8.00', 6, '', '02 : 17', '', 0, 0, 101, '2019-08-11 03:21:03'),
(388, 102, 20, 1, '5.00', 6, '', '05 : 16', '', 0, 0, 100, '2019-08-11 03:21:03'),
(389, 102, 31, 1, '5.00', 6, '', '05 : 20', '', 0, 0, 100, '2019-08-11 03:21:03'),
(390, 100, 21, 1, '12.00', 6, '', '13 : 19', '', 0, 0, 101, '2019-08-11 03:21:03'),
(391, 103, 8, 3, '6.00', 6, '', '00 : 01', '', 1, 0, 103, '2019-08-11 03:21:03'),
(392, 104, 3, 2, '4.00', 6, '', NULL, '', 0, 1, 0, '2019-08-11 03:21:03'),
(393, 104, 4, 2, '7.00', 6, '', NULL, '', 0, 1, 0, '2019-08-11 03:21:03'),
(394, 104, 10, 2, '15.00', 6, '', NULL, '', 0, 1, 0, '2019-08-11 03:21:03'),
(395, 104, 11, 3, '15.00', 6, '', NULL, '', 0, 1, 0, '2019-08-11 03:21:03'),
(396, 104, 51, 3, '10.00', 6, '', NULL, '', 0, 1, 0, '2019-08-11 03:21:03'),
(397, 104, 52, 1, '2.00', 6, '', NULL, '', 0, 1, 0, '2019-08-11 03:21:03'),
(398, 104, 34, 2, '2.00', 6, '', NULL, '', 0, 1, 0, '2019-08-11 03:21:03'),
(399, 104, 44, 3, '2.50', 6, '', NULL, '', 0, 1, 0, '2019-08-11 03:21:03'),
(400, 104, 41, 1, '3.50', 6, '', NULL, '', 0, 1, 0, '2019-08-11 03:21:03'),
(401, 104, 42, 1, '7.00', 6, '', NULL, '', 0, 1, 0, '2019-08-11 03:21:03'),
(402, 104, 48, 1, '5.00', 6, '', NULL, '', 0, 1, 0, '2019-08-11 03:21:03'),
(403, 104, 56, 1, '5.00', 6, '', NULL, '', 0, 1, 0, '2019-08-11 03:21:03'),
(404, 105, 3, 1, '4.00', 6, '', NULL, '', 0, 0, 0, '2019-08-11 03:21:03'),
(405, 105, 4, 1, '7.00', 6, '', NULL, '', 0, 0, 0, '2019-08-11 03:21:03'),
(406, 105, 10, 1, '15.00', 6, '', '00 : 14', '', 0, 0, 108, '2019-08-11 03:21:03'),
(407, 105, 11, 1, '15.00', 6, '', '00 : 12', '', 0, 0, 108, '2019-08-11 03:21:03'),
(408, 105, 51, 1, '10.00', 6, '', '00 : 19', '', 0, 0, 108, '2019-08-11 03:21:03'),
(409, 105, 52, 1, '2.00', 6, '', '00 : 17', '', 0, 0, 108, '2019-08-11 03:21:03'),
(410, 105, 34, 1, '2.00', 6, '', '00 : 13', '', 0, 0, 108, '2019-08-11 03:21:03'),
(411, 105, 44, 1, '2.50', 6, '', '00 : 16', '', 0, 0, 108, '2019-08-11 03:21:03'),
(412, 105, 41, 1, '3.50', 6, '', '00 : 15', '', 0, 0, 108, '2019-08-11 03:21:03'),
(413, 105, 42, 1, '7.00', 6, '', '00 : 16', '', 0, 0, 108, '2019-08-11 03:21:03'),
(414, 105, 48, 1, '5.00', 6, '', '00 : 23', '', 0, 0, 108, '2019-08-11 03:21:03'),
(415, 105, 56, 1, '5.00', 6, '', '00 : 18', '', 0, 0, 108, '2019-08-11 03:21:03'),
(416, 105, 12, 2, '3.00', 6, '', '00 : 05', '', 0, 0, 108, '2019-08-11 03:21:03'),
(417, 105, 13, 1, '3.00', 6, '', '00 : 06', '', 0, 0, 108, '2019-08-11 03:21:03'),
(418, 105, 44, 2, '2.50', 6, '', NULL, '', 0, 0, 0, '2019-08-11 03:21:03'),
(419, 106, 3, 1, '4.00', 6, '', '00 : 03', '', 0, 0, 109, '2019-08-11 03:21:03'),
(420, 106, 4, 1, '7.00', 6, '', '00 : 04', '', 0, 0, 109, '2019-08-11 03:21:03'),
(421, 106, 10, 1, '15.00', 6, '', '00 : 05', '', 0, 0, 109, '2019-08-11 03:21:03'),
(422, 106, 11, 1, '15.00', 6, '', '00 : 01', '', 0, 0, 109, '2019-08-11 03:21:03'),
(423, 106, 51, 1, '10.00', 6, '', '00 : 06', '', 0, 0, 109, '2019-08-11 03:21:03'),
(424, 106, 52, 1, '2.00', 6, '', '00 : 08', '', 0, 0, 109, '2019-08-11 03:21:03'),
(425, 106, 34, 1, '2.00', 6, '', '00 : 02', '', 0, 0, 109, '2019-08-11 03:21:03'),
(426, 106, 44, 1, '2.50', 6, '', '00 : 05', '', 0, 0, 109, '2019-08-11 03:21:03'),
(427, 106, 41, 1, '3.50', 6, '', NULL, '', 0, 0, 0, '2019-08-11 03:21:03'),
(428, 106, 3, 1, '4.00', 6, '', '00 : 00', '', 0, 0, 109, '2019-08-11 03:21:03'),
(429, 106, 3, 7, '4.00', 6, '', NULL, '', 0, 1, 0, '2019-08-11 03:21:03'),
(430, 107, 3, 1, '4.00', 6, '', '00 : 02', '', 0, 0, 110, '2019-08-11 03:21:03'),
(431, 107, 4, 1, '7.00', 6, '', '00 : 01', '', 0, 0, 110, '2019-08-11 03:21:03'),
(432, 108, 10, 1, '15.00', 6, '', NULL, '', 0, 0, 0, '2019-08-11 03:21:03'),
(433, 108, 11, 1, '15.00', 6, '', '00 : 04', '', 0, 0, 114, '2019-08-11 03:21:03'),
(434, 109, 51, 1, '10.00', 6, '', '00 : 08', '', 0, 0, 111, '2019-08-11 03:21:03'),
(435, 109, 52, 1, '2.00', 6, '', '00 : 07', '', 0, 0, 111, '2019-08-11 03:21:03'),
(436, 110, 34, 1, '2.00', 6, '', '00 : 08', '', 0, 0, 116, '2019-08-11 03:21:03'),
(437, 110, 44, 1, '2.50', 6, '', '00 : 12', '', 0, 0, 116, '2019-08-11 03:21:03'),
(438, 111, 41, 3, '3.50', 6, '', '00 : 10', '', 0, 0, 117, '2019-08-11 03:21:03'),
(439, 112, 3, 1, '4.00', 6, '', '00 : 10', '', 0, 0, 118, '2019-08-11 03:21:03'),
(440, 112, 4, 2, '7.00', 6, '', '00 : 11', '', 0, 0, 118, '2019-08-11 03:21:03'),
(441, 113, 12, 1, '3.00', 6, '', '01 : 16', '', 0, 0, 113, '2019-08-11 03:21:03'),
(442, 113, 13, 1, '3.00', 6, '', '02 : 13', '', 0, 0, 113, '2019-08-11 03:21:03'),
(443, 113, 12, 1, '3.00', 6, '', '01 : 43', '', 0, 0, 113, '2019-08-11 03:21:03'),
(444, 113, 12, 1, '3.00', 6, '', '02 : 10', 'what', 0, 0, 113, '2019-08-11 03:21:03'),
(445, 114, 31, 1, '5.00', 6, '', '15 : 00', '', 0, 0, 115, '2019-08-11 03:21:03'),
(446, 114, 45, 1, '1.00', 6, '', '15 : 00', '', 0, 0, 115, '2019-08-11 03:21:03'),
(447, 114, 12, 1, '3.00', 6, '', '15 : 00', '', 0, 0, 115, '2019-08-11 03:21:03'),
(448, 115, 14, 1, '3.00', 6, '', '15 : 00', '', 0, 0, 119, '2019-08-11 03:21:03'),
(449, 115, 15, 1, '3.50', 6, '', '15 : 00', '', 0, 0, 119, '2019-08-11 03:21:03'),
(450, 115, 18, 1, '6.00', 6, '', '15 : 00', '', 0, 0, 119, '2019-08-11 03:21:03'),
(451, 115, 15, 2, '3.50', 6, '', '15 : 00', '', 0, 0, 119, '2019-08-11 03:21:03'),
(452, 113, 12, 1, '3.00', 6, '', '01 : 45', '', 0, 0, 113, '2019-08-11 03:21:03'),
(453, 116, 12, 1, '3.00', 6, '', '15 : 00', '', 0, 0, 120, '2019-08-11 03:21:03'),
(454, 117, 12, 1, '3.00', 6, '', '15 : 00', '', 0, 0, 112, '2019-08-11 03:21:03'),
(455, 118, 12, 1, '3.00', 6, '', '00 : 01', '', 0, 0, 121, '2019-08-11 03:21:03'),
(456, 119, 12, 1, '3.00', 6, '', '02 : 41', '', 0, 0, 0, '2019-08-11 03:21:03'),
(457, 119, 13, 1, '3.00', 6, '', '02 : 50', '', 0, 0, 0, '2019-08-11 03:21:03'),
(458, 119, 12, 1, '3.00', 6, '', '02 : 43', '', 0, 0, 0, '2019-08-11 03:21:03'),
(459, 120, 12, 1, '3.00', 6, '', '03 : 12', '', 0, 0, 0, '2019-08-11 03:21:03'),
(460, 120, 13, 3, '3.00', 6, '', '03 : 14', '', 0, 0, 0, '2019-08-11 03:21:03'),
(461, 119, 12, 1, '3.00', 6, '', '00 : 31', '', 0, 0, 0, '2019-08-11 03:21:03'),
(462, 119, 12, 1, '3.00', 6, '', '00 : 59', '', 0, 0, 0, '2019-08-11 03:21:03'),
(463, 119, 12, 1, '3.00', 6, '', '01 : 27', '', 0, 0, 0, '2019-08-11 03:21:03'),
(464, 119, 12, 1, '3.00', 6, '', '00 : 06', '', 0, 0, 0, '2019-08-11 03:21:03'),
(465, 119, 12, 1, '3.00', 6, '', '00 : 09', '', 0, 0, 0, '2019-08-11 03:21:03'),
(466, 119, 12, 1, '3.00', 6, '', '00 : 01', '', 0, 0, 0, '2019-08-11 03:21:03'),
(467, 119, 12, 1, '3.00', 6, '', '00 : 03', '', 0, 0, 0, '2019-08-11 03:21:03'),
(468, 119, 12, 1, '3.00', 6, '', '00 : 39', '', 0, 0, 0, '2019-08-11 03:21:03'),
(469, 119, 12, 3, '3.00', 6, '', '00 : 40', '', 0, 0, 0, '2019-08-11 03:21:03'),
(470, 119, 12, 1, '3.00', 6, '', '07 : 15', '', 0, 0, 0, '2019-08-11 03:21:03'),
(471, 119, 12, 1, '3.00', 6, '', '07 : 17', '', 0, 0, 0, '2019-08-11 03:21:03'),
(472, 119, 13, 1, '3.00', 6, '', '07 : 20', '', 0, 0, 0, '2019-08-11 03:21:03'),
(473, 119, 15, 1, '3.50', 6, '', '00 : 01', '', 0, 0, 0, '2019-08-11 03:21:03'),
(474, 119, 12, 1, '3.00', 6, '', '03 : 51', '', 0, 0, 0, '2019-08-11 03:21:03'),
(475, 120, 12, 1, '3.00', 6, '', '00 : 48', '', 0, 0, 0, '2019-08-11 03:21:03'),
(476, 120, 16, 1, '4.00', 6, '', '01 : 19', '', 0, 0, 0, '2019-08-11 03:21:03'),
(477, 119, 12, 1, '3.00', 6, '', '02 : 48', '', 0, 0, 0, '2019-08-11 03:21:03'),
(478, 119, 17, 1, '5.00', 6, '', '02 : 50', '', 0, 0, 0, '2019-08-11 03:21:03'),
(479, 120, 18, 1, '6.00', 6, '', '01 : 25', '', 0, 0, 0, '2019-08-11 03:21:03'),
(480, 119, 21, 1, '12.00', 6, '', '00 : 05', '', 0, 0, 0, '2019-08-11 03:21:03'),
(481, 121, 8, 1, '6.00', 6, '', '01 : 00', '', 1, 0, 0, '2019-08-11 03:21:03'),
(482, 122, 8, 1, '6.00', 6, '', '00 : 28', '', 1, 0, 0, '2019-08-11 03:21:03'),
(483, 121, 8, 1, '6.00', 6, '', NULL, '', 1, 0, 0, '2019-08-11 03:21:03'),
(484, 122, 8, 1, '6.00', 6, '', NULL, '', 1, 0, 0, '2019-08-11 03:21:03'),
(485, 123, 1, 1, '8.00', 6, '', NULL, '', 1, 0, 0, '2019-08-11 03:21:03'),
(486, 123, 2, 1, '8.00', 6, '', NULL, '', 2, 0, 0, '2019-08-11 03:21:03'),
(487, 123, 1, 2, '8.00', 6, '', NULL, '', 3, 0, 0, '2019-08-11 03:21:03'),
(488, 124, 1, 1, '8.00', 6, '', '01 : 17', '', 1, 0, 122, '2019-08-11 03:21:03'),
(489, 124, 2, 1, '8.00', 6, '', '01 : 19', '', 1, 0, 122, '2019-08-11 03:21:03'),
(490, 124, 3, 2, '4.00', 6, '', '01 : 12', '', 0, 0, 122, '2019-08-11 03:21:03'),
(491, 124, 12, 1, '3.00', 6, '', NULL, '', 0, 1, 0, '2019-08-11 03:21:03'),
(492, 125, 3, 1, '4.00', 6, '', '00 : 03', '', 0, 0, 123, '2019-08-11 03:21:03'),
(493, 125, 4, 1, '7.00', 6, '', '00 : 01', '', 0, 0, 123, '2019-08-11 03:21:03'),
(494, 126, 1, 5, '8.00', 6, '', '03 : 53', '', 1, 0, 0, '2019-08-11 03:21:03'),
(495, 126, 3, 2, '4.00', 6, '', '01 : 11', '', 0, 0, 0, '2019-08-11 03:21:03'),
(496, 126, 4, 5, '7.00', 6, '', '00 : 29', '', 0, 0, 0, '2019-08-11 03:21:03'),
(497, 127, 3, 3, '4.00', 6, '', NULL, '', 0, 0, 0, '2019-08-11 03:21:03'),
(498, 127, 10, 6, '15.00', 6, '', '00:00', '', 0, 0, 0, '2019-08-11 03:21:03'),
(499, 128, 51, 2, '10.00', 6, '', NULL, '', 0, 0, 0, '2019-08-11 03:21:03'),
(500, 128, 52, 1, '2.00', 6, '', NULL, '', 0, 0, 0, '2019-08-11 03:21:03'),
(501, 129, 34, 4, '2.00', 6, '', NULL, '', 0, 0, 0, '2019-08-11 03:49:30'),
(502, 130, 41, 1, '3.50', 4, '', NULL, '', 0, 0, 0, '2019-08-11 04:40:22'),
(503, 130, 42, 1, '7.00', 4, '', NULL, '', 0, 0, 0, '2019-08-11 04:40:22'),
(504, 131, 10, 1, '15.00', 4, '', NULL, '', 0, 1, 0, '2019-08-11 23:29:21'),
(505, 131, 11, 1, '15.00', 4, '', NULL, '', 0, 1, 0, '2019-08-11 23:29:21'),
(506, 132, 3, 1, '4.00', 4, '', NULL, '', 0, 1, 0, '2019-08-11 23:54:22'),
(507, 132, 4, 1, '7.00', 4, '', NULL, '', 0, 1, 0, '2019-08-11 23:54:22'),
(508, 133, 11, 2, '15.00', 4, '', NULL, '', 0, 1, 0, '2019-08-12 00:42:43'),
(509, 134, 3, 1, '4.00', 4, '', NULL, '', 0, 1, 0, '2019-08-12 00:51:50'),
(510, 134, 4, 1, '7.00', 4, '', NULL, '', 0, 1, 0, '2019-08-12 00:51:50'),
(511, 135, 4, 2, '7.00', 4, '', NULL, '', 0, 1, 0, '2019-08-12 01:26:00'),
(512, 136, 10, 1, '15.00', 4, '', NULL, '', 0, 1, 0, '2019-08-12 02:33:21'),
(513, 137, 10, 1, '15.00', 4, '', NULL, '', 0, 1, 0, '2019-08-12 02:33:31'),
(514, 138, 10, 2, '15.00', 4, '', NULL, '', 0, 1, 0, '2019-08-12 02:44:51'),
(515, 139, 10, 1, '15.00', 4, '', NULL, '', 0, 0, 0, '2019-08-12 02:50:26'),
(516, 140, 10, 1, '15.00', 4, '', NULL, '', 0, 0, 0, '2019-08-12 02:54:35'),
(517, 141, 3, 1, '4.00', 4, '', NULL, '', 0, 0, 0, '2019-08-12 15:01:07'),
(518, 141, 4, 1, '7.00', 4, '', NULL, '', 0, 0, 0, '2019-08-12 15:01:07'),
(519, 142, 3, 1, '4.00', 4, '', NULL, '', 0, 0, 0, '2019-08-12 15:02:25'),
(520, 143, 3, 1, '4.00', 4, '', NULL, '', 0, 0, 0, '2019-08-12 15:03:27'),
(521, 144, 3, 1, '4.00', 4, '', NULL, '', 0, 0, 0, '2019-08-12 15:15:45'),
(522, 145, 3, 2, '4.00', 4, '', NULL, '', 0, 0, 0, '2019-08-12 16:13:57'),
(523, 146, 3, 1, '4.00', 4, '', NULL, '', 0, 0, 0, '2019-08-12 16:26:37'),
(524, 147, 4, 2, '7.00', 4, '', NULL, '', 0, 1, 0, '2019-08-12 16:28:02'),
(525, 148, 3, 1, '4.00', 4, '', NULL, '', 0, 1, 0, '2019-08-12 16:35:03'),
(526, 149, 4, 1, '7.00', 4, '', NULL, '', 0, 1, 0, '2019-08-12 16:35:17'),
(527, 150, 10, 2, '15.00', 2, '', '02:44', '', 0, 0, 0, '2019-08-12 16:39:41'),
(528, 150, 3, 3, '4.00', 4, '', NULL, '', 0, 0, 0, '2019-08-12 16:43:42'),
(529, 151, 6, 1, '6.00', 4, '', NULL, '', 1, 0, 0, '2019-08-12 16:52:25'),
(530, 151, 8, 1, '6.00', 4, '', NULL, '', 1, 0, 0, '2019-08-12 16:52:25'),
(531, 151, 3, 1, '4.00', 4, '', NULL, '', 0, 0, 0, '2019-08-12 16:52:25'),
(532, 152, 3, 1, '4.00', 4, '', NULL, '', 0, 0, 0, '2019-08-12 16:53:30'),
(533, 153, 12, 3, '3.00', 4, '', NULL, '', 0, 0, 0, '2019-08-12 17:02:40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `id_empleado` int(11) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '0',
  `clave` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `id_empleado`, `estado`, `clave`) VALUES
(1, 1, 1, '31c0c178a9fc26ffecffd8670e6d746d'),
(2, 2, 1, '202cb962ac59075b964b07152d234b70'),
(3, 3, 1, '202cb962ac59075b964b07152d234b70'),
(4, 4, 0, '202cb962ac59075b964b07152d234b70'),
(5, 5, 1, '202cb962ac59075b964b07152d234b70'),
(6, 6, 1, '202cb962ac59075b964b07152d234b70');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `utensilio`
--

CREATE TABLE `utensilio` (
  `id` int(11) NOT NULL,
  `nombre` varchar(75) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `utensilio`
--

INSERT INTO `utensilio` (`id`, `nombre`, `estado`) VALUES
(1, 'LECHUGA', 1),
(2, 'Tomate', 1),
(3, 'Palta', 1),
(4, 'Cebolla', 1),
(5, 'Mayonesa', 1),
(6, 'Ketchup', 1),
(7, 'Mostaza', 1),
(8, 'Aji', 1),
(9, 'Majote', 1),
(10, 'Bituca', 1),
(11, 'Yucas', 1),
(12, 'Recacha', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `utensilio_producto`
--

CREATE TABLE `utensilio_producto` (
  `id` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `id_utensilio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `utensilio_producto`
--

INSERT INTO `utensilio_producto` (`id`, `id_producto`, `id_utensilio`) VALUES
(19, 1, 4),
(21, 1, 7),
(22, 1, 3),
(23, 1, 2),
(24, 10, 9),
(25, 10, 11),
(26, 10, 12),
(27, 10, 10),
(28, 11, 9),
(29, 11, 10),
(30, 11, 11),
(31, 11, 12);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `dni` (`dni`);

--
-- Indices de la tabla `estado_proceso`
--
ALTER TABLE `estado_proceso`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `facturacion`
--
ALTER TABLE `facturacion`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `mesa`
--
ALTER TABLE `mesa`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `promocion_bonus`
--
ALTER TABLE `promocion_bonus`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `promocion_puntos`
--
ALTER TABLE `promocion_puntos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `serie_comprobante`
--
ALTER TABLE `serie_comprobante`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo_comprobante`
--
ALTER TABLE `tipo_comprobante`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo_empleado`
--
ALTER TABLE `tipo_empleado`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo_servicio`
--
ALTER TABLE `tipo_servicio`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `toma_pedido`
--
ALTER TABLE `toma_pedido`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `utensilio`
--
ALTER TABLE `utensilio`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `utensilio_producto`
--
ALTER TABLE `utensilio_producto`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `estado_proceso`
--
ALTER TABLE `estado_proceso`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `facturacion`
--
ALTER TABLE `facturacion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=124;

--
-- AUTO_INCREMENT de la tabla `mesa`
--
ALTER TABLE `mesa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `pedido`
--
ALTER TABLE `pedido`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=154;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT de la tabla `promocion_bonus`
--
ALTER TABLE `promocion_bonus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `promocion_puntos`
--
ALTER TABLE `promocion_puntos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `serie_comprobante`
--
ALTER TABLE `serie_comprobante`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tipo_empleado`
--
ALTER TABLE `tipo_empleado`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tipo_servicio`
--
ALTER TABLE `tipo_servicio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `toma_pedido`
--
ALTER TABLE `toma_pedido`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=534;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `utensilio`
--
ALTER TABLE `utensilio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `utensilio_producto`
--
ALTER TABLE `utensilio_producto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
