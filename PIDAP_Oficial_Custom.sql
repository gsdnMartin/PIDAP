PGDMP     
    3            	    {            PIDAP    15.4    15.4 $    0           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            1           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            2           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            3           1262    16398    PIDAP    DATABASE     �   CREATE DATABASE "PIDAP" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE "PIDAP";
                postgres    false            �            1259    16578    comercio_exterior    TABLE       CREATE TABLE public.comercio_exterior (
    id_ce integer NOT NULL,
    id_distribuidora integer NOT NULL,
    tipo character varying NOT NULL,
    unidad character varying NOT NULL,
    periodo date NOT NULL,
    movimiento character varying NOT NULL,
    valor numeric NOT NULL
);
 %   DROP TABLE public.comercio_exterior;
       public         heap    postgres    false            �            1259    16537    distribuidora    TABLE     �   CREATE TABLE public.distribuidora (
    id_distribuidora integer NOT NULL,
    id_estado integer,
    id_pozo integer,
    ubicacion character varying NOT NULL,
    cp integer NOT NULL
);
 !   DROP TABLE public.distribuidora;
       public         heap    postgres    false            �            1259    16508    estado    TABLE     �   CREATE TABLE public.estado (
    id_estado integer NOT NULL,
    nombre character varying NOT NULL,
    min_cp integer NOT NULL,
    max_cp integer NOT NULL
);
    DROP TABLE public.estado;
       public         heap    postgres    false            �            1259    16515    pozo    TABLE     m   CREATE TABLE public.pozo (
    id_pozo integer NOT NULL,
    id_estado integer,
    periodo date NOT NULL
);
    DROP TABLE public.pozo;
       public         heap    postgres    false            �            1259    16525 
   produccion    TABLE     �   CREATE TABLE public.produccion (
    id_produccion integer NOT NULL,
    id_pozo integer,
    tipo character varying NOT NULL,
    unidad character varying(5) NOT NULL,
    periodo date NOT NULL,
    valor numeric
);
    DROP TABLE public.produccion;
       public         heap    postgres    false            �            1259    16590 	   productos    TABLE     �   CREATE TABLE public.productos (
    id_productos integer NOT NULL,
    id_distribuidora integer NOT NULL,
    magna boolean NOT NULL,
    premium boolean NOT NULL,
    diesel boolean NOT NULL,
    dme boolean NOT NULL
);
    DROP TABLE public.productos;
       public         heap    postgres    false            �            1259    16554    quejas    TABLE     �   CREATE TABLE public.quejas (
    id_queja integer NOT NULL,
    id_distribuidora integer NOT NULL,
    estado character varying NOT NULL,
    anio integer NOT NULL
);
    DROP TABLE public.quejas;
       public         heap    postgres    false            �            1259    16566    ventas_internas    TABLE     �   CREATE TABLE public.ventas_internas (
    id_vi integer NOT NULL,
    id_distribuidora integer NOT NULL,
    tipo character varying NOT NULL,
    unidad character varying(5) NOT NULL,
    periodo date NOT NULL,
    valor numeric
);
 #   DROP TABLE public.ventas_internas;
       public         heap    postgres    false            ,          0    16578    comercio_exterior 
   TABLE DATA           n   COPY public.comercio_exterior (id_ce, id_distribuidora, tipo, unidad, periodo, movimiento, valor) FROM stdin;
    public          postgres    false    220   a-       )          0    16537    distribuidora 
   TABLE DATA           \   COPY public.distribuidora (id_distribuidora, id_estado, id_pozo, ubicacion, cp) FROM stdin;
    public          postgres    false    217   ~-       &          0    16508    estado 
   TABLE DATA           C   COPY public.estado (id_estado, nombre, min_cp, max_cp) FROM stdin;
    public          postgres    false    214   �-       '          0    16515    pozo 
   TABLE DATA           ;   COPY public.pozo (id_pozo, id_estado, periodo) FROM stdin;
    public          postgres    false    215   �/       (          0    16525 
   produccion 
   TABLE DATA           Z   COPY public.produccion (id_produccion, id_pozo, tipo, unidad, periodo, valor) FROM stdin;
    public          postgres    false    216   �0       -          0    16590 	   productos 
   TABLE DATA           `   COPY public.productos (id_productos, id_distribuidora, magna, premium, diesel, dme) FROM stdin;
    public          postgres    false    221   [=       *          0    16554    quejas 
   TABLE DATA           J   COPY public.quejas (id_queja, id_distribuidora, estado, anio) FROM stdin;
    public          postgres    false    218   x=       +          0    16566    ventas_internas 
   TABLE DATA           `   COPY public.ventas_internas (id_vi, id_distribuidora, tipo, unidad, periodo, valor) FROM stdin;
    public          postgres    false    219   �=       �           2606    16584 (   comercio_exterior comercio_exterior_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.comercio_exterior
    ADD CONSTRAINT comercio_exterior_pkey PRIMARY KEY (id_ce);
 R   ALTER TABLE ONLY public.comercio_exterior DROP CONSTRAINT comercio_exterior_pkey;
       public            postgres    false    220            �           2606    16543     distribuidora distribuidora_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.distribuidora
    ADD CONSTRAINT distribuidora_pkey PRIMARY KEY (id_distribuidora);
 J   ALTER TABLE ONLY public.distribuidora DROP CONSTRAINT distribuidora_pkey;
       public            postgres    false    217            �           2606    16514    estado estado_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.estado
    ADD CONSTRAINT estado_pkey PRIMARY KEY (id_estado);
 <   ALTER TABLE ONLY public.estado DROP CONSTRAINT estado_pkey;
       public            postgres    false    214            �           2606    16519    pozo pozo_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.pozo
    ADD CONSTRAINT pozo_pkey PRIMARY KEY (id_pozo);
 8   ALTER TABLE ONLY public.pozo DROP CONSTRAINT pozo_pkey;
       public            postgres    false    215            �           2606    16531    produccion produccion_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.produccion
    ADD CONSTRAINT produccion_pkey PRIMARY KEY (id_produccion);
 D   ALTER TABLE ONLY public.produccion DROP CONSTRAINT produccion_pkey;
       public            postgres    false    216            �           2606    16594    productos productos_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (id_productos);
 B   ALTER TABLE ONLY public.productos DROP CONSTRAINT productos_pkey;
       public            postgres    false    221            �           2606    16560    quejas quejas_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.quejas
    ADD CONSTRAINT quejas_pkey PRIMARY KEY (id_queja);
 <   ALTER TABLE ONLY public.quejas DROP CONSTRAINT quejas_pkey;
       public            postgres    false    218            �           2606    16572 $   ventas_internas ventas_internas_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.ventas_internas
    ADD CONSTRAINT ventas_internas_pkey PRIMARY KEY (id_vi);
 N   ALTER TABLE ONLY public.ventas_internas DROP CONSTRAINT ventas_internas_pkey;
       public            postgres    false    219            �           2606    16585 9   comercio_exterior comercio_exterior_id_distribuidora_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.comercio_exterior
    ADD CONSTRAINT comercio_exterior_id_distribuidora_fkey FOREIGN KEY (id_distribuidora) REFERENCES public.distribuidora(id_distribuidora);
 c   ALTER TABLE ONLY public.comercio_exterior DROP CONSTRAINT comercio_exterior_id_distribuidora_fkey;
       public          postgres    false    3207    220    217            �           2606    16544 *   distribuidora distribuidora_id_estado_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.distribuidora
    ADD CONSTRAINT distribuidora_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES public.estado(id_estado);
 T   ALTER TABLE ONLY public.distribuidora DROP CONSTRAINT distribuidora_id_estado_fkey;
       public          postgres    false    217    214    3201            �           2606    16549 (   distribuidora distribuidora_id_pozo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.distribuidora
    ADD CONSTRAINT distribuidora_id_pozo_fkey FOREIGN KEY (id_pozo) REFERENCES public.pozo(id_pozo);
 R   ALTER TABLE ONLY public.distribuidora DROP CONSTRAINT distribuidora_id_pozo_fkey;
       public          postgres    false    215    3203    217            �           2606    16520    pozo pozo_id_estado_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pozo
    ADD CONSTRAINT pozo_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES public.estado(id_estado);
 B   ALTER TABLE ONLY public.pozo DROP CONSTRAINT pozo_id_estado_fkey;
       public          postgres    false    3201    214    215            �           2606    16532 "   produccion produccion_id_pozo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.produccion
    ADD CONSTRAINT produccion_id_pozo_fkey FOREIGN KEY (id_pozo) REFERENCES public.pozo(id_pozo);
 L   ALTER TABLE ONLY public.produccion DROP CONSTRAINT produccion_id_pozo_fkey;
       public          postgres    false    215    3203    216            �           2606    16595 )   productos productos_id_distribuidora_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_id_distribuidora_fkey FOREIGN KEY (id_distribuidora) REFERENCES public.distribuidora(id_distribuidora);
 S   ALTER TABLE ONLY public.productos DROP CONSTRAINT productos_id_distribuidora_fkey;
       public          postgres    false    221    217    3207            �           2606    16561 #   quejas quejas_id_distribuidora_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.quejas
    ADD CONSTRAINT quejas_id_distribuidora_fkey FOREIGN KEY (id_distribuidora) REFERENCES public.distribuidora(id_distribuidora);
 M   ALTER TABLE ONLY public.quejas DROP CONSTRAINT quejas_id_distribuidora_fkey;
       public          postgres    false    218    3207    217            �           2606    16573 5   ventas_internas ventas_internas_id_distribuidora_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ventas_internas
    ADD CONSTRAINT ventas_internas_id_distribuidora_fkey FOREIGN KEY (id_distribuidora) REFERENCES public.distribuidora(id_distribuidora);
 _   ALTER TABLE ONLY public.ventas_internas DROP CONSTRAINT ventas_internas_id_distribuidora_fkey;
       public          postgres    false    217    3207    219            ,      x������ � �      )      x������ � �      &   �  x�]R�n�0=��"_�b;�=G�"��V�@�L���*WI���c����1��"�rxo潙������2И��L��2����0�-�S"0ZXSY�?����J��l���C�	�agT�C�'b3��3W�C!~����T��o��ٞ�Oi� �vܭl2��������.dxLG��*��E�iz�`e�c�Jkx�����Z��C�o�6��D��Vnu������y�3�L���}���N��w	J����ZX��t��S��6�L����L�4x��9�y':��wJ��4������W%~��e<���Ɏ�Wʴ�N48��"o4\�x��yQ���v�x���J���u��z�L�V΢�����I⦃M�eIKs�׼���B��a�&3A�l��b��gFe���D����T���>RS�� ��?�� ܌t�;&@�G��V�n�L�\~�٠(Y_�@kE����)�q`��Qƿ{�������      '   P  x�E�ɑ!C��\f
o��e��{�{��"������I~����J��5���R:�B{�M�S��~R_rț2�:�?њo���7W<���/�W~Y��0uo��F$��(�\��� aZ���J�0$��C0�0C����)�۳9��{���w���!�f�0��(]u�#��Ѕ��W�Fah��#�CmNh��1*�nb��z:��B#�����4�=���0�S@a�r

ôoG�a��Ea،R�a�-i�x$���(@|��3�(@\z�:r*@�h(�w�8|�.�ᇦAa���	qDc�'����}��n�;      (   P  x��Z���<�O�Ȁ��f�Qp�@�%rt�S��!�T���~N��`ذT����*r�t-���_����?}���/��?�U�Q���)dJG'�ƕ_���`:�Z��-@�8���U-�[�b-���ڋ��w>�2�V{���� ��^G��s$ڎ޻P�����=7:�5
�W�K;D�dTj�h�O�y;F�a^�=��N���*q�ml(OU�`���1q;)3�׆��S[|���0f1�ԗ4x�'k!:��W�"���sj�P~�->y3�0j��e���I,�4�JQ�~�I��V����<�q����L+��#�	���GE(��9���B���[|����a-��}P���`Vԏ^d�|��!F�4qD����&y�o:�VEVѧI��G�Y�v��vK�;��zveE:�3z?�F�<�Ã;(��5��ZZ�7�H�3�c=�����g�a?ȩ�K���g�A���ҹ����>���T$�ý�9�����p��|����?ȃ�jޭ�	�:\��q9���>�^>O��F�����Yy؀�8�=>�cv8��V�«����lݱ~lV��O��4 �Ne�\<�]�Y YT_�'�3}ED�Ⱆ��'}P9QxD���+-O����Ө:֕�'�xL��R�'}0�j�����,'}|�����[�U6�I� F\��z䤏?���1�
����9�^�&{�O�}��5��d�#�P=ѣv���AGmc	4Ɗ��J��q��>J߇$�k� o<*��B��Ѫ����	�� w�������o_?�R>��?#zՠ`�e��g$7p�i�7��$[�.�w�Հ,�����w��@��zʑ<U���P�KG��.��
�������{��zKmdн;���>��>)�7p�g�N��"���g)4���uh�u��b��]�5�fǙ���l�\�Q��d���O���$�ch��|*^=��������z�S�mh�
iT�e����0�"�b�J���h����~x���A;��3PGdM��A�h,��?Ǚ^S`j]��L�?��FA�h�)��SJ���@�暪Kj������Q��-7�ڏ��s��k�r����?*UG�\0�f���H�AV}��>5��d=�$���^��UC^=��m��KzS�@*�h���
WG�Q}��|$f
�	�	�����/���R��L8��N������8խ_��j���x�%��[�R�m�8�4j>�4����S�j�"7�×s��%#�׈U��VS�2�9rkK�������`��Tt�əFisP����$�
j5u��u�Z��_�,�'�wx�u��>���$7�������تgO]����Q`�ǲt��� ���~���ûv�\~,�s�Z�(7�y=��"eOY���*�7പ��Ef+�6��P�;<��14p^n���r�T���!;� �e'>U�� �}Y�NY��{��z��>u-��D����U�=u-Q������-��S�S��w���?��뇿}�A�|�������5�T�twU����\F�R�ː�,O��z���>����Cq������������^��J���M��y�t�V�Ck4P*ǎ�{=v|�Zb�?o�^���-hW����
w���6`���dT	�h��v�"k<Z�t��ǂY���M��	��fJ^A 821Vn�T�(��x�o�X}^˿��4���k��?=���g�-(Q���������Űem/�����V�u�CTR���cAg��h��Ɲ#����_{t���Q5��7#��Nc,=/�_�M2�7|p���^���$3Z�B�+?pBI�L@D��~5��ݱ`s�3C/al�wB�I�������nK_���$���c�ݜ�+%2e
�q�;ID�8#:d!"R��4y��$�L��Zu��N���$[�!�=���������՜���N}��#�/Ypܠx���%o��=Ū��Ә�������8"�9���㈺��v)Y�轞�����i`�(����:d���\`L�yKLyx�Mk�7-�󚨒�{�pڜ�A�|mƒ�~d�Ić�W���@�;Q>����&��y0y�ξ;J�h!�3R�����14�J�%W�o)�i�<�-�!�����*�<���˵�[2���ZC�p����4Q�OE�
�Q�{cOC�ؘ|s����sB��rX�Жw�4������#o�����{�h>&4��i��Vw���`�z^�����_6����>���y����s>�al2zح<z������6���nĽ����y+�����9M)��o�>��˯��޻�r@�[�
���x~�#�#����	�b�� ���蚷�k8������{_�>��%��g��y��_��q�pD��}���=
%L7�ܩ�G�K8$jr�|� �h\��k>�@�@/E�Iy��GOq��T6a�~mҰ,=�$�%�+G�`ɫ���>�[��-16��[����������ё~~u	��M<kUX�-%obE��y�E̟o&�5%�ç����P��<mp^�^��f�RK�y�2��m�]nOOs	�R�5��Ԁ��W�JDf�7XR\�u�%�AfBc��|þ���u��jc���l
����tڅs��K4&�t����iL�z	OO� ����}~s	�;hE��� ��n-�б5tM�L�,�~BX�s@8�<��j��P!��O׀����H<���<��@���m`rk����4 ��k�K8��;#���/��8�&�.�����q]����|�~<�`���V�A��XE�T���[1u�%|Q�P��.n�M�O��E�_+Y0���hF���������)� �`��y�v	��adF>s1�UE:ո@b���6��<K�i^�v!�<�@������l�p�&��\@Z�h�	_���[��/H [g�j3���7;����V;=��Kq����)�5��i�]��FO���߆�?	����%<��t_U�R^8��Y<��Z�Ȩ�L/��Ծ,�6����
� <.K��H/A)iս�fJ�����_I1�      -      x������ � �      *      x������ � �      +      x������ � �     